package: Python-modules
version: "1.0"
requires:
  - "Python:slc.*"
  - "Python-system:(?!slc.*)"
  - FreeType
  - libpng
build_requires:
  - curl
env:
  PYTHON_MODULES_ROOT: "/cvmfs/alice-nightlies.cern.ch/el7-x86_64/Packages/Python-modules/1.0-49"
  PYTHON_ROOT: "/cvmfs/alice-nightlies.cern.ch/el7-x86_64/Packages/Python/v3.6.8-5/"
  PYTHONHOME: "$PYTHON_ROOT"
  PYTHONPATH: "$PYTHON_ROOT/lib/python/site-packages"
prepend_path:
  PATH: "$PYTHON_ROOT/bin"
  PYTHONPATH: $PYTHON_MODULES_ROOT/lib/python/site-packages
  LD_LIBRARY_PATH: "$PYTHON_ROOT/lib"
---
#!/bin/bash -ex


# Modulefile
MODULEDIR="$INSTALLROOT/etc/modulefiles"
MODULEFILE="$MODULEDIR/$PKGNAME"
mkdir -p "$MODULEDIR"
cat > "$MODULEFILE" <<EoF
#%Module1.0
proc ModulesHelp { } {
  global version
  puts stderr "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
}
set version $PKGVERSION-@@PKGREVISION@$PKGHASH@@
module-whatis "ALICE Modulefile for $PKGNAME $PKGVERSION-@@PKGREVISION@$PKGHASH@@"
# Dependencies
module load BASE/1.0 ${ALIEN_RUNTIME_VERSION:+AliEn-Runtime/$ALIEN_RUNTIME_VERSION-$ALIEN_RUNTIME_REVISION}
# Python from cvmfs
setenv PYTHON_ROOT /cvmfs/alice-nightlies.cern.ch/el7-x86_64/Packages/Python/v3.6.8-5/
setenv PYTHONHOME $::env(PYTHON_ROOT)
setenv PYTHONPATH $::env(PYTHON_ROOT)/lib/python/site-packages"
prepend-path PATH $::env(PYTHON_ROOT)/bin
prepend-path LD_LIBRARY_PATH $::env(PYTHON_ROOT)/lib
# Our environment
setenv PYTHON_MODULES_ROOT /cvmfs/alice-nightlies.cern.ch/el7-x86_64/Packages/Python-modules/1.0-49
prepend-path PATH $::env(PYTHON_MODULES_ROOT)/bin
prepend-path LD_LIBRARY_PATH $::env(PYTHON_MODULES_ROOT)/lib
$([[ ${ARCHITECTURE:0:3} == osx ]] && echo "prepend-path DYLD_LIBRARY_PATH $::env(PYTHON_MODULES_ROOT)/lib")
prepend-path PYTHONPATH $::env(PYTHON_MODULES_ROOT)/lib/python/site-packages
EoF
