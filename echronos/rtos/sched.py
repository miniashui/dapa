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

"""
A model of the RTOS schedulers in Python.

This can be used for testing purposes to ensure implementation matches the model.

"""
from itertools import product
import ctypes


def head(iter_):
    """Return the first item in an iterator, or None if the iterator is empty."""
    try:
        return next(iter_)
    except StopIteration:
        return None


def rotate(sequence, n):
    """Rotate a sequence by n positions.

    Note: This function returns a new list; it does not mutate the seqeunce.

    """
    return sequence[n:] + sequence[:n]


def incmod(i, n):
    return (i + 1) % n


def get_rr_sched_struct(num_tasks):
    """Return an implementation mock for a round-robin scheduler with 'num_tasks' tasks."""
    class RrSchedTaskStruct(ctypes.Structure):
        _fields_ = [("runnable", ctypes.c_bool)]

    class RrSchedStruct(ctypes.Structure):
        _fields_ = [("cur", ctypes.c_uint8),
                    ("tasks", RrSchedTaskStruct * num_tasks)]

        def __str__(self):
            run_state = ''.join(['X' if x.runnable else ' ' for x in self.tasks])
            return "<RrSchedImpl cur={} runnable=[{}]".format(self.cur, run_state)

        def __eq__(self, model):
            if model.cur != self.cur:
                return False
            for idx, r in model.indexed:
                if self.tasks[idx].runnable != r:
                    return False
            return True

        def set(self, model):
            self.cur = model.cur
            for idx, r in model.indexed:
                self.tasks[idx].runnable = r
            assert self == model
    return RrSchedStruct


def get_prio_sched_struct(num_tasks):
    """Return an implementation mock for a priority scheduler with 'num_tasks' tasks."""
    class PrioSchedTaskStruct(ctypes.Structure):
        _fields_ = [("runnable", ctypes.c_bool)]

    class PrioSchedStruct(ctypes.Structure):
        _fields_ = [("tasks", PrioSchedTaskStruct * num_tasks)]

        def __str__(self):
            run_state = ''.join(['X' if x.runnable else ' ' for x in self.tasks])
            return "<PrioSchedImpl runnable=[{}]".format(run_state)

        def __eq__(self, model):
            for idx, r in model.indexed:
                if self.tasks[idx].runnable != r:
                    return False
            return True

        def set(self, model):
            for idx, r in model.indexed:
                self.tasks[idx].runnable = r
            assert self == model
    return PrioSchedStruct


def get_prio_inherit_sched_struct(num_tasks):
    """Return an implementation mock for a prioity inheritance scheduler with 'num_tasks' tasks."""
    class PrioInheritTaskStruct(ctypes.Structure):
        _fields_ = [("blocked_on", ctypes.c_uint8)]

    class PrioInheritSchedStruct(ctypes.Structure):
        _fields_ = [("tasks", PrioInheritTaskStruct * num_tasks)]

        def __str__(self):
            blocked_on = ''.join(['{:d}'.format(x.blocked_on) if x.blocked_on is not 0xff else '.'
                                  for x in self.tasks])
            return "<PrioInheritSchedImpl blocked_on=[{}]".format(blocked_on)

        def __eq__(self, model):
            for idx, r in enumerate(model.blocked_on):
                if r is None:
                    r = 0xff
                if self.tasks[idx].blocked_on != r:
                    return False
            return True

        def set(self, model):
            for idx, blocked_on in enumerate(model.blocked_on):
                if blocked_on is None:
                    blocked_on = 0xff
                self.tasks[idx].blocked_on = blocked_on
            assert self == model
    return PrioInheritSchedStruct


class BaseSchedModel:
    def __init__(self, runnable):
        self.runnable = runnable
        self.size = len(runnable)

    @property
    def indexed(self):
        """Return the runnable list as tuples (index, runnable)."""
        return list(enumerate(self.runnable))

    @property
    def runnable_str(self):
        return ''.join(['X' if r else ' ' for r in self.runnable])

    def get_next(self):
        """Based on the scheduling algorithm return the next task to run.

        This method may mutate the scheduler object.

        This method should be implemented by a sub-class.

        """
        raise Exception("get_next should be implemented by sub-class.")


class RrSchedModel(BaseSchedModel):
    """A model of the round-robin scheduler."""

    def __init__(self, runnable, cur):
        super().__init__(runnable)
        self.cur = cur

    def __str__(self):
        return '<RrSched cur={} runnable=[{}]>'.format(self.cur, self.runnable_str)

    def get_next(self):
        next_ = head(idx for idx, runnable in rotate(self.indexed, incmod(self.cur, self.size)) if runnable)
        self.cur = self.size - 1 if next_ is None else next_
        return next_

    @classmethod
    def states(cls, n, assume_runnable=False):
        """Return all possible round-robin scheduler states for n tasks.

        If assume_runnable is True then only include states where at least one task is runnable.

        """
        g = (cls(*s) for s in product(product((True, False), repeat=n), range(n)))
        return filter(lambda s: any(s.runnable), g) if assume_runnable else g


class PrioSchedModel(BaseSchedModel):
    """A model of the strict priority scheduler."""

    def __str__(self):
        return '<PrioSched runnable=[{}]>'.format(self.runnable_str)

    def get_next(self):
        return head(idx for idx, runnable in self.indexed if runnable)

    @classmethod
    def states(cls, n, assume_runnable=False):
        """Return all possible priority scheduler states for n tasks.

        If assume_runnable is True then only include states where at least one task is runnable.

        """
        g = (cls(s) for s in product((True, False), repeat=n))
        return filter(lambda s: any(s.runnable), g) if assume_runnable else g


class PrioInheritSchedModel(BaseSchedModel):
    """A model of the strict priority with inheritance scheduler."""

    def __init__(self, blocked_on):
        self.blocked_on = blocked_on

    @property
    def blocked_on_str(self):
        return ''.join(['{:d}'.format(r) if r is not None else '.' for r in self.blocked_on])

    @property
    def any_runnable(self):
        return any(idx == val for idx, val in enumerate(self.blocked_on))

    def __str__(self):
        return '<PrioInheritSched blocked_on=[{}]>'.format(self.blocked_on_str)

    def get_next(self):
        def resolve_block_chain(task_id):
            seen = set()
            while True:
                blocked_on = self.blocked_on[task_id]
                assert blocked_on not in seen
                if blocked_on in (task_id, None):
                    return blocked_on
                else:
                    seen.add(task_id)
                    task_id = blocked_on

        return head(task_id for
                    task_id in map(resolve_block_chain, range(len(self.blocked_on)))
                    if task_id is not None)

    @classmethod
    def states(cls, n, assume_runnable=False):
        """Return all possible priority scheduler states for n tasks.

        If assume_runnable is True then only include states where at least one task is runnable.

        """
        def check_blocked(blocked_list, task_id):
            seen = set()
            while True:
                blocked_on = blocked_list[task_id]
                if blocked_on in seen:
                    return False
                elif blocked_on in (task_id, None):
                    return True
                else:
                    seen.add(task_id)
                    task_id = blocked_on

        def check_blocked_list(blocked_list):
            r = all(check_blocked(blocked_list, task_id) for task_id in range(len(blocked_list)))
            return r
        g = (cls(s) for s in product(list(range(n)) + [None], repeat=n) if check_blocked_list(s))
        return filter(lambda s: s.any_runnable, g) if assume_runnable else g


if __name__ == '__main__':
    import sys
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument('--assume-runnable', action='store_true',
                        help="Ensure schedulers have at least 1 runnable task.")
    parser.add_argument('--sched', choices=['prio', 'rr'], required=True)
    parser.add_argument('N', type=int,
                        help="Number of tasks in scheduler.")
    args = parser.parse_args()

    sched_class = {'prio': PrioSchedModel, 'rr': RrSchedModel}[args.sched]

    for s in sched_class.states(args.N, args.assume_runnable):
        before = str(s)
        next_ = s.get_next()
        after = str(s)
        print("{:>5}  {}  {} ".format(next_, before, after))
