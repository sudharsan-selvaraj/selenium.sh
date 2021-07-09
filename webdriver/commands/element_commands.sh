#!/usr/bin/env bash

source "${SELENIUM_SOURCE_DIR}/webdriver/commands/command_executor.sh"

########################################################################################
#                                ELEMENT METHODS                                     #
########################################################################################

##
## Method to find element
##
__ELEMENT_FIND_ELEMENT__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  __FIND_ELEMENT__ "${base_url}" ${session_id} "${base_url}/session/${session_id}/element/${element_id}" "${@:4}"
}

##
## Method to find elements
##
__ELEMENT_FIND_ELEMENTS__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  __FIND_ELEMENTS__ "${base_url}" ${session_id} "${base_url}/session/${session_id}/element/${element_id}" "${@:4}"
}

##
## Method to enter text in input fields
##
__ELEMENT_SEND_KEYS__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${base_url}/session/${session_id}/element/${element_id}/value" "$4")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get attribute of web element
##
__ELEMENT_GET_ATTRIBUTE__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${base_url}/session/${session_id}/element/${element_id}/attribute/$4")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to enter text in input fields
##
__ELEMENT_CLICK__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${base_url}/session/${session_id}/element/${element_id}/click" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}
