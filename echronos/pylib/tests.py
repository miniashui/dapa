#
# eChronos Real-Time Operating System
# Copyright (C) 2015  National ICT Australia Limited (NICTA), ABN 62 102 206 173.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, version 3, provided that these additional
# terms apply under section 7:
#
#   No right, title or interest in or to any trade mark, service mark, logo or
#   trade name of of National ICT Australia Limited, ABN 62 102 206 173
#   ("NICTA") or its licensors is granted. Modified versions of the Program
#   must be plainly marked as such, and must not be distributed using
#   "eChronos" as a trade mark or product name, or misrepresented as being the
#   original Program.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# @TAG(NICTA_AGPL)
#

import os
import sys
import pep8
import logging
import unittest
import subprocess
from contextlib import contextmanager
import difflib
import io
import re
import nose
import inspect

from .xunittest import discover_tests, TestSuite, SimpleTestNameResult, testcase_matches, testsuite_list
from .release import _LicenseOpener
from .utils import get_executable_extension, BASE_DIR, find_path, base_to_top_paths
from .cmdline import subcmd, Arg


_std_subcmd_args = (
    Arg('tests', metavar='TEST', nargs='*', default=[]),
    Arg('--list', action='store_true', help="List tests (don't execute)", default=False),
    Arg('--verbose', action='store_true', default=False),
    Arg('--quiet', action='store_true', default=False),
)


@subcmd(cmd="test", args=_std_subcmd_args)
def prj(args):
    """Run tests associated with prj modules."""
    modules = ['prj', 'util']
    directories = [find_path(os.path.join('prj', 'app'), args.topdir),
                   find_path(os.path.join('prj', 'app', 'pystache'), args.topdir),
                   find_path(os.path.join('prj', 'app', 'lib'), args.topdir)]

    return _run_module_tests_with_args(modules, directories, args)


@subcmd(cmd="test", args=_std_subcmd_args)
def x(args):
    """Run x-related tests."""
    modules = ['x']
    directories = ['.']

    return _run_module_tests_with_args(modules, directories, args)


@subcmd(cmd="test")
def pystache(args):
    """Run tests assocaited with pystache modules."""
    return subprocess.call([sys.executable,
                            find_path(os.path.join('prj', 'app', 'pystache', 'test_pystache.py'), args.topdir)])


@subcmd(cmd="test", args=_std_subcmd_args)
def units(args):
    """Run rtos unit tests."""
    modules = ['rtos']
    directories = ['.']

    return _run_module_tests_with_args(modules, directories, args)


def _run_module_tests_with_args(modules, directories, args):
    """Call a fixed set of modules in specific directories, deriving all input for a call to _run_module_tests() from
    the given command line arguments.

    See `run_modules_tests` for more information.

    """
    patterns = args.tests
    verbosity = 0
    if args.verbose:
        verbosity = 1
    if args.quiet:
        verbosity = -1
    print_only = args.list
    topdir = args.topdir

    return _run_module_tests(modules, directories, patterns, verbosity, print_only, topdir)


def _run_module_tests(modules, directories, patterns=None, verbosity=0, print_only=False, topdir=""):
    """Discover and run the tests associated with the given modules and located in the given directories.

    'modules' is list of module names as a sequence of strings.
    Only tests related to these modules are to be discovered.

    'directories' is a list of relative directory names as a sequence of strings.
    Only tests located in these directories are to be discovered.

    'patterns' is a list of test name patterns as a sequence of strings.
    If 'patterns' is not empty, only the tests whose names match one of the patterns are honored and all other
    discovered tests are ignored.
    If 'patterns' is empty, all discovered tests are honored.

    The integer 'verbosity' controls the amount of generated console output when executing the tests.
    A value of 0 selects the default verbosity level, positive values increase it, negative values reduce it.

    If the boolean 'print_only' is True, the discovered tests are printed on the console but not executed.

    Returns a process exit code suitable for passing to sys.exit().
    The exit code represents the number of tests that failed (0 indicating all tests passed).
    If more than 127 tests failed, then 127 will be returned.
    127 is the largest, portable value that can be returned via sys.exit().

    """
    result = 0

    paths = [os.path.join(topdir, dir) for dir in directories]
    if all([os.path.exists(p) for p in paths]):
        with _python_path(*paths):
            all_tests = discover_tests(*modules)

            if patterns:
                tests = (t for t in all_tests if any(testcase_matches(t, p) for p in patterns))
            else:
                tests = all_tests

            suite = TestSuite(tests)

            if print_only:
                testsuite_list(suite)
            else:
                BASE_VERBOSITY = 1
                runner = unittest.TextTestRunner(resultclass=SimpleTestNameResult,
                                                 verbosity=BASE_VERBOSITY + verbosity)
                run_result = runner.run(suite)
                result = min(len(run_result.failures), 127)

    return result


@contextmanager
def _python_path(*paths):
    """A context manager that adds (and removes) one or more directories from the Python path.

    This allows extending the Python path temporarily to load certain modules.
    The directories are expected as individual arguments, e.g., "with _python_path('foo', 'bar'):"

    """
    paths = [os.path.abspath(path) for path in paths]
    sys.path = paths + sys.path
    try:
        yield
    finally:
        del sys.path[:len(paths)]


class _TeamcityReport(pep8.StandardReport):
    """Collect results and print teamcity messages."""

    def __init__(self, options):
        super(_TeamcityReport, self).__init__(options)

    def get_file_results(self):
        ret = super(_TeamcityReport, self).get_file_results()
        if self.file_errors:
            self._teamcity("testFailed name='%s'" % self._test_name())
        self._teamcity("testFinished name='%s'" % self._test_name())
        return ret

    def init_file(self, filename, lines, expected, line_offset):
        ret = super(_TeamcityReport, self).init_file(filename, lines, expected, line_offset)
        self._teamcity("testStarted name='%s' captureStandardOutput='true'" % self._test_name())
        return ret

    @staticmethod
    def _teamcity(msg):
        print("##teamcity[{}]".format(msg))

    def _test_name(self):
        return self.filename[:-3].replace("|", "||").replace("'", "|'").replace("[", "|[") \
            .replace("]", "|]").replace("\n", "|n").replace("\r", "|r")


@subcmd(cmd="test", help='Run PEP8 on project Python files',
        args=(Arg('--teamcity', action='store_true', help="Provide teamcity output for tests", default=False),
              Arg('--excludes', nargs='*', help="Exclude directories from pep8 checks", default=[])))
def style(args):
    """Check for PEP8 compliance with the pep8 tool.

    This implements conventions lupHw1 and u1wSS9.
    The enforced maximum line length follows convention TZb0Uv.

    When the pep8 tool finds all project Python files to be compliant, this function returns None.
    When a non-compliant file is found, details about the non-compliance are printed on the standard output stream and
    this function returns 1.
    Runtime errors encountered by the pep8 tool are printed on the standard error stream and raised as the appropriate
    exceptions.

    """
    excludes = ['external_tools', 'pystache', 'tools', 'ply'] + args.excludes
    exclude_patterns = ','.join(excludes)
    options = ['--exclude=' + exclude_patterns, '--max-line-length', '118', os.path.join(args.topdir, ".")]

    logging.info('pep8 check: ' + ' '.join(options))

    pep8style = pep8.StyleGuide(arglist=options)
    if args.teamcity:
        pep8style.init_report(_TeamcityReport)
    report = pep8style.check_files()
    if report.total_errors:
        logging.error('pep8 check found non-compliant files')  # details on stdout
        return 1


@subcmd(cmd="test", help='Check that all files have the appropriate license header',
        args=(Arg('--excludes', nargs='*', help="Exclude directories from license header checks", default=[]),))
def licenses(args):
    files_without_license = []
    files_unknown_type = []

    sep = os.path.sep
    if sep == '\\':
        sep = '\\\\'
    pattern = re.compile('\.git|components{0}.*\.(c|h|xml|md)$|external_tools{0}|pm{0}|prj{0}app{0}(ply|pystache){0}|\
provenance{0}|out{0}|release{0}|prj_build|tools{0}|docs{0}manual_template|packages{0}[^{0}]+{0}rtos-|\
.*__pycache__'.format(sep))
    for dirpath, subdirs, files in os.walk(BASE_DIR):
        for file_name in files:
            path = os.path.join(dirpath, file_name)
            rel_path = os.path.relpath(path, BASE_DIR)
            if not pattern.match(rel_path):
                # Check setenv as a shell script and expect shell-style comment format for .pylintrc
                if rel_path in ('setenv', '.pylintrc'):
                    agpl_sentinel = _LicenseOpener._agpl_sentinel('.sh')
                else:
                    ext = os.path.splitext(file_name)[1]
                    try:
                        agpl_sentinel = _LicenseOpener._agpl_sentinel(ext)
                    except _LicenseOpener.UnknownFiletypeException:
                        files_unknown_type.append(path)
                        continue

                if agpl_sentinel is not None:
                    f = open(path, 'rb')
                    old_lic_str, sentinel_found, _ = f.peek().decode('utf8').partition(agpl_sentinel)
                    if not sentinel_found:
                        files_without_license.append(path)
                    f.close()

    if len(files_without_license):
        logging.error('License check found files without a license header:')
        for file_path in files_without_license:
            logging.error('    {}'.format(file_path))

    if len(files_unknown_type):
        logging.error('License check found files of unknown type:')
        for file_path in files_unknown_type:
            logging.error('    {}'.format(file_path))
        return 1

    if len(files_without_license):
        return 1


@subcmd(cmd="test", help='Check that all files belonging to external tools map 1-1 with provenance listings')
def provenance(args):
    target_dirs = base_to_top_paths(args.topdir, ('tools', 'external_tools'))
    exemptions = [os.path.join(BASE_DIR, 'tools', 'LICENSE.md'),
                  os.path.join(BASE_DIR, 'external_tools', 'LICENSE.md')]
    files_nonexistent = []
    files_not_listed = []
    files_listed = []

    # Check that all files in provenance FILES listings exist.
    for provenance_path in base_to_top_paths(args.topdir, 'provenance'):
        for dirpath, subdirs, files in os.walk(provenance_path):
            for list_path in [os.path.join(dirpath, f) for f in files if f == 'FILES']:
                for file_path in [line.strip() for line in open(list_path)]:
                    file_abs_path = os.path.normpath(os.path.join(os.path.dirname(provenance_path), file_path))
                    if os.path.exists(file_abs_path):
                        files_listed.append(file_abs_path)
                    else:
                        files_nonexistent.append((file_path, list_path))

    # Check that all files in 'external_tools' and 'tools' are listed in a provenance FILES listing.
    for target_dir in target_dirs:
        for dirpath, subdirs, files in os.walk(target_dir):
            # Exempt any __pycache__ dirs from the check
            if '__pycache__' in subdirs:
                subdirs.remove('__pycache__')

            # Exempt tools/share/xyz from the check.
            # This directory contains xyz-generated provenance information including file listings with paths relative
            # to the 'tools' directory, sometimes including other files in tools/share/xyz, so we leave them here to
            # preserve their paths and put a note in the relevant ORIGIN files to refer here for more info.
            if dirpath == os.path.abspath(os.path.join(BASE_DIR, 'tools', 'share')) and 'xyz' in subdirs:
                subdirs.remove('xyz')

            for file_path in [os.path.normpath(os.path.join(dirpath, f)) for f in files]:
                if file_path not in files_listed + exemptions:
                    files_not_listed.append(file_path)

    # Log all results and return 1 if there were any problematic cases
    if len(files_nonexistent):
        logging.error('Provenance check found files listed that don\'t exist:')
        for file_path, list_path in files_nonexistent:
            logging.error('    {} (listed in {})'.format(file_path, list_path))

    if len(files_not_listed):
        logging.error('Provenance check found files without provenance information:')
        for file_path in files_not_listed:
            logging.error('    {}'.format(file_path))
        return 1

    if len(files_nonexistent):
        return 1


@subcmd(cmd="test", help='Run system tests, i.e., tests that check the behavior of full RTOS systems. \
This command supports the same options as the Python nose test framework.')
def systems(args):
    def find_gdb_test_py_files(path):
        for parent, dirs, files in os.walk(path):
            for file in files:
                if file.endswith('.py') and os.path.splitext(file)[0] + '.gdb' in files:
                    yield os.path.join(parent, file)

    tests = []
    uargs = args.unknown_args
    if not uargs or not isinstance(uargs[-1], str) or not uargs[-1].endswith('.py'):
        for packages_dir in base_to_top_paths(args.topdir, 'packages'):
            tests.extend(find_gdb_test_py_files(packages_dir))

    nose.core.run(argv=[''] + args.unknown_args + tests)


class GdbTestCase(unittest.TestCase):
    """A Pythonic interface to running an RTOS system executable against a GDB command file and checking whether the
    output produced matches a given reference output.

    The external interface of this class is that of unittest.TestCase to be accessed by the unittest or nose
    frameworks.

    To use this class for new tests, import this class in a Python file under the packages/ directory.
    That Python file needs to have the same file name as the .prx file containing the system configuration of the
    system to build and test, the .gdb file containing the GDB commands to execute against the system executable, and
    the .gdbout file containing the expected GDB output.
    The default implementation of this class then picks up these files and runs the test.

    If building or running or testing a system requires additional logic beyond this default implementation, create a
    subclass of this class and extend it accordingly.

    """
    system_name = None

    def setUp(self):
        topdir = os.path.abspath('.')
        self.search_paths = list(base_to_top_paths(topdir, 'packages'))
        if self.system_name is None:
            py_path = inspect.getfile(self.__class__)
            self.prx_path = os.path.splitext(py_path)[0] + '.prx'
            rel_py_path = os.path.relpath(py_path, os.path.abspath(self.search_paths[0]))
            self.system_name = os.path.splitext(rel_py_path)[0].replace(os.sep, '.')
        else:
            rel_prx_path = os.path.join('packages', self.system_name.replace('.', os.sep) + '.prx')
            self.prx_path = list(base_to_top_paths(topdir, rel_prx_path))[0]
        self.executable_path = os.path.abspath(os.path.join('out', self.system_name.replace('.', os.sep),
                                                            'system' + get_executable_extension()))
        self.gdb_commands_path = os.path.splitext(self.prx_path)[0] + '.gdb'
        self._build()

    def test(self):
        assert os.path.exists(self.executable_path)
        assert os.path.exists(self.gdb_commands_path)
        test_output = self._get_test_output()
        reference_output = self._get_reference_output()
        if test_output != reference_output:
            for line in difflib.unified_diff(reference_output.splitlines(), test_output.splitlines(),
                                             'reference', 'test'):
                sys.stdout.write(line + '\n')
        assert test_output == reference_output

    def _build(self):
        subprocess.check_call([sys.executable, os.path.join(BASE_DIR, 'prj', 'app', 'prj.py')] +
                              ['--search-path={}'.format(sp) for sp in self.search_paths] +
                              ['build', self.system_name])

    def _get_test_output(self):
        test_command = self._get_test_command()
        gdb_output = subprocess.check_output(test_command)
        return self._filter_gdb_output(gdb_output.decode())

    def _get_test_command(self):
        return ('gdb', '--batch', self.executable_path, '-x', self.gdb_commands_path)

    def _get_reference_output(self):
        reference_path = os.path.splitext(self.prx_path)[0] + '.gdbout'
        return self._filter_gdb_output(open(reference_path).read())

    @staticmethod
    def _filter_gdb_output(gdb_output):
        delete_patterns = (re.compile('^(\[New Thread .+)$'),)
        replace_patterns = (re.compile('Breakpoint [0-9]+ at (0x[0-9a-f]+): file (.+), line ([0-9]+)'),
                            re.compile('^Breakpoint .* at (.+)$'),
                            re.compile('=(0x[0-9a-f]+)'),
                            re.compile('Inferior( [0-9]+ )\[process( [0-9]+\]) will be killed'),
                            re.compile('^([0-9]+\t.+)$'),
                            re.compile('^rtos_internal_entry \(\) at (.+)$'))
        filtered_result = io.StringIO()
        for line in gdb_output.splitlines(True):
            match = None
            for pattern in delete_patterns:
                match = pattern.search(line)
                if match:
                    break
            if match:
                continue
            for pattern in replace_patterns:
                while True:
                    match = pattern.search(line)
                    if match:
                        for group in match.groups():
                            line = line.replace(group, '')
                    else:
                        break
            filtered_result.write(line)
        return filtered_result.getvalue()
