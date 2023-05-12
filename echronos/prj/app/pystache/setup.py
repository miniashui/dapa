#!/usr/bin/env python
# coding: utf-8

"""
This script supports publishing Pystache to PyPI.

This docstring contains instructions to Pystache maintainers on how
to release a new version of Pystache.

(1) Prepare the release.

Make sure the code is finalized and merged to master.  Bump the version
number in setup.py, etc.

Generate the reStructuredText long_description using--

    python setup.py prep

and be sure this new version is checked in.  You must have pandoc installed
to do this step:

    http://johnmacfarlane.net/pandoc/

It helps to review this auto-generated file on GitHub prior to uploading
because the long description will be sent to PyPI and appear there after
publishing.

(2) Push to PyPI.  To release a new version of Pystache to PyPI--

    http://pypi.python.org/pypi/pystache

create a PyPI user account if you do not already have one.  The user account
will need permissions to push to PyPI.  A current "Package Index Owner" of
Pystache can grant you those permissions.

When you have permissions, run the following:

    python setup.py publish

If you get an error like the following--

    Upload failed (401): You must be identified to edit package information

then add a file called .pyirc to your home directory with the following
contents:

    [server-login]
    username: <PyPI username>
    password: <PyPI password>

as described here, for example:

    http://docs.python.org/release/2.5.2/dist/pypirc.html

(3) Tag the release on GitHub.  Here are some commands for tagging.

List current tags:

    git tag -l -n3

Create an annotated tag:

    git tag -a -m "Version 0.5.1" "v0.5.1"

Push a tag to GitHub:

    git push --tags defunkt v0.5.1

"""

import os
import shutil
import sys


py_version = sys.version_info

# distutils does not seem to support the following setup() arguments.
# It displays a UserWarning when setup() is passed those options:
#
#  * entry_points
#  * install_requires
#
# distribute works with Python 2.3.5 and above:
#
#   http://packages.python.org/distribute/setuptools.html#building-and-distributing-packages-with-distribute
#
if py_version < (2, 3, 5):
    # TODO: this might not work yet.
    import distutils as dist
    from distutils import core
    setup = core.setup
else:
    import setuptools as dist
    setup = dist.setup


VERSION = '0.5.3-alpha'  # Also change in pystache/__init__.py.

FILE_ENCODING = 'utf-8'

README_PATH = 'README.md'
HISTORY_PATH = 'HISTORY.md'
LICENSE_PATH = 'LICENSE'

DESCRIPTION_PATH = 'setup_description.rst'

TEMP_REST_EXTENSION = '.temp.rst'

PREP_COMMAND = 'prep'

CLASSIFIERS = (
    'Development Status :: 4 - Beta',
    'License :: OSI Approved :: MIT License',
    'Programming Language :: Python',
    'Programming Language :: Python :: 2',
    'Programming Language :: Python :: 2.4',
    'Programming Language :: Python :: 2.5',
    'Programming Language :: Python :: 2.6',
    'Programming Language :: Python :: 2.7',
    'Programming Language :: Python :: 3',
    'Programming Language :: Python :: 3.1',
    'Programming Language :: Python :: 3.2',
    'Programming Language :: Python :: Implementation :: PyPy',
)


def read(path):
    """
    Read and return the contents of a text file as a unicode string.

    """
    # This function implementation was chosen to be compatible across Python 2/3.
    f = open(path, 'rb')
    # We avoid use of the with keyword for Python 2.4 support.
    try:
        b = f.read()
    finally:
        f.close()

    return b.decode(FILE_ENCODING)


def write(u, path):
    """
    Write a unicode string to a file (as utf-8).

    """
    print("Writing to: %s" % path)
    # This function implementation was chosen to be compatible across Python 2/3.
    f = open(path, "wb")
    try:
        b = u.encode(FILE_ENCODING)
        f.write(b)
    finally:
        f.close()


def make_temp_path(path):
    root, ext = os.path.splitext(path)
    temp_path = root + TEMP_REST_EXTENSION
    return temp_path


def make_description_file(target_path):
    """
    Generate the long_description needed for setup.py.

    The long description needs to be formatted as reStructuredText:

      http://docs.python.org/distutils/setupscript.html#additional-meta-data

    """
    # Comments in reST begin with two dots.
    intro = """\
.. This file is auto-generated by setup.py for PyPI using pandoc, so this
.. file should not be edited.  Edits should go in the source files.
"""

    readme_path = convert_md_to_rst(README_PATH)
    history_path = convert_md_to_rst(HISTORY_PATH)

    license = """\
License
=======

""" + read(LICENSE_PATH)

    sections = [intro, read(readme_path), read(history_path), license]

    description = '\n'.join(sections)

    write(description, target_path)


def prep():
    make_description_file(DESCRIPTION_PATH)

def publish():
    """
    Publish this package to PyPI (aka "the Cheeseshop").

    """
    temp_path = make_temp_path(DESCRIPTION_PATH)
    make_description_file(temp_path)

    if read(temp_path) != read(DESCRIPTION_PATH):
        print("""\
Description file not up-to-date: %s
Run the following command and commit the changes--

    python setup.py %s
""" % (DESCRIPTION_PATH, PREP_COMMAND))
        sys.exit()

    print("Description up-to-date: %s" % DESCRIPTION_PATH)

    answer = raw_input("Are you sure you want to publish to PyPI (yes/no)?")

    if answer != "yes":
        exit("Aborted: nothing published")

    os.system('python setup.py sdist upload')


def convert_md_to_rst(path):
    """
    Convert the given file from markdown to reStructuredText.

    Returns the new path.

    """
    temp_path = make_temp_path(path)
    print("Converting: %s to %s" % (path, temp_path))

    if os.path.exists(temp_path):
        os.remove(temp_path)

    # Pandoc uses the UTF-8 character encoding for both input and output.
    command = "pandoc --write=rst --output=%s %s" % (temp_path, path)
    os.system(command)

    if not os.path.exists(temp_path):
        s = ("Error running: %s\n"
             "  Did you install pandoc per the %s docstring?" % (command, __file__))
        sys.exit(s)

    return temp_path


# We use the package simplejson for older Python versions since Python
# does not contain the module json before 2.6:
#
#   http://docs.python.org/library/json.html
#
# Moreover, simplejson stopped officially support for Python 2.4 in version 2.1.0:
#
#   https://github.com/simplejson/simplejson/blob/master/CHANGES.txt
#
requires = []
if py_version < (2, 5):
    requires.append('simplejson<2.1')
elif py_version < (2, 6):
    requires.append('simplejson')

INSTALL_REQUIRES = requires

# TODO: decide whether to use find_packages() instead.  I'm not sure that
#   find_packages() is available with distutils, for example.
PACKAGES = [
    'pystache',
    'pystache.commands',
    # The following packages are only for testing.
    'pystache.tests',
    'pystache.tests.data',
    'pystache.tests.data.locator',
    'pystache.tests.examples',
]


# The purpose of this function is to follow the guidance suggested here:
#
#   http://packages.python.org/distribute/python3.html#note-on-compatibility-with-setuptools
#
# The guidance is for better compatibility when using setuptools (e.g. with
# earlier versions of Python 2) instead of Distribute, because of new
# keyword arguments to setup() that setuptools may not recognize.
def get_extra_args():
    """
    Return a dictionary of extra args to pass to setup().

    """
    extra = {}
    # TODO: it might be more correct to check whether we are using
    #   Distribute instead of setuptools, since use_2to3 doesn't take
    #   effect when using Python 2, even when using Distribute.
    if py_version >= (3, ):
        # Causes 2to3 to be run during the build step.
        extra['use_2to3'] = True

    return extra


def main(sys_argv):

    # TODO: use the logging module instead of printing.
    # TODO: include the following in a verbose mode.
    print("pystache: using: version %s of %s" % (repr(dist.__version__), repr(dist)))

    command = sys_argv[-1]

    if command == 'publish':
        publish()
        sys.exit()
    elif command == PREP_COMMAND:
        prep()
        sys.exit()

    long_description = read(DESCRIPTION_PATH)
    template_files = ['*.mustache', '*.txt']
    extra_args = get_extra_args()

    setup(name='pystache',
          version=VERSION,
          license='MIT',
          description='Mustache for Python',
          long_description=long_description,
          author='Chris Wanstrath',
          author_email='chris@ozmm.org',
          maintainer='Chris Jerdonek',
          maintainer_email='chris.jerdonek@gmail.com',
          url='http://github.com/defunkt/pystache',
          install_requires=INSTALL_REQUIRES,
          packages=PACKAGES,
          package_data = {
              # Include template files so tests can be run.
              'pystache.tests.data': template_files,
              'pystache.tests.data.locator': template_files,
              'pystache.tests.examples': template_files,
          },
          entry_points = {
            'console_scripts': [
                'pystache=pystache.commands.render:main',
                'pystache-test=pystache.commands.test:main',
            ],
          },
          classifiers = CLASSIFIERS,
          **extra_args
    )


if __name__=='__main__':
    main(sys.argv)
