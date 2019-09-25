package: Python-system
version: "3.6"
system_requirement_missing: |
  Python 3.6 is missing from your system. We need the python3 and pip3 executables in the PATH.
  It can be installed with:
   * On Ubuntu: sudo apt-get install python3 python3-pip python3-tk
   * On macOS: brew install python3
env:
  PYTHON_MODULES_ROOT: "/cvmfs/alice-nightlies.cern.ch/el7-x86_64/Packages/Python-modules/1.0-49"
  PYTHON_ROOT: "/cvmfs/alice-nightlies.cern.ch/el7-x86_64/Packages/Python/v3.6.8-5/"
  PYTHONHOME: "$PYTHON_ROOT"
  PYTHONPATH: "$PYTHON_ROOT/lib/python/site-packages"
prepend_path:
  PATH: "$PYTHON_ROOT/bin"
  PYTHONPATH: $PYTHON_MODULES_ROOT/lib/python/site-packages
  LD_LIBRARY_PATH: "$PYTHON_ROOT/lib"
system_requirement: ".*"
system_requirement_check: |
  export PYTHONHOME="/cvmfs/alice-nightlies.cern.ch/el7-x86_64/Packages/Python/v3.6.8-5/"; export PATH="$PYTHONHOME/bin:$PATH"; export LD_LIBRARY_PATH="$PYTHONHOME/lib:$LD_LIBRARY_PATH"; export PYTHONPATH="$PYTHON_ROOT/lib/python/site-packages"; python3 -c 'import sys; import sqlite3; sys.exit(1 if sys.version_info < (3,5) else 0)' && pip3 help
---
