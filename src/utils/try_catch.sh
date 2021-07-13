#!/usr/bin/env bash

__inside_try__="false"
__PARENT_BASH_ID="$$"
__TRY_CATCH_SUBSHELL_ID__=0

function begin() {
  __TRY_CATCH_SUBSHELL_ID__=$(exec sh -c 'echo "$PPID"')
}

function try() {
  __inside_try__="true"
  [[ $- == *e* ]]
  SAVED_OPT_E=$?
  set +e
}

function throw() {
  exit $1
}

function catch() {
  export exception_code=$?
  (($SAVED_OPT_E)) && set +e
  __TRY_CATCH_SUBSHELL_ID__=$(exec sh -c 'echo "$PPID"')
  if [ ${__TRY_CATCH_SUBSHELL_ID__} == ${__PARENT_BASH_ID} ]; then
    __inside_try__="false"
  else
    __inside_try__="true"
  fi
  return $exception_code
}
