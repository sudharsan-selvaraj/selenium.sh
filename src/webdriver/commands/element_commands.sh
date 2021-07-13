#!/usr/bin/env bash
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
## Method to clear the value of webelement
##
__ELEMENT_CLEAR_VALUE__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${base_url}/session/${session_id}/element/${element_id}/clear")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to enter text in input fields
##
__ELEMENT_SEND_KEYS__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local body='{ "text" : "'$4'"}'
  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${base_url}/session/${session_id}/element/${element_id}/value" "$body")
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
## Method to get attribute of web element
##
__ELEMENT_GET_PROPERTY__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${base_url}/session/${session_id}/element/${element_id}/property/$4")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get attribute of web element
##
__ELEMENT_GET_CSS_VALUE__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${base_url}/session/${session_id}/element/${element_id}/css/$4")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to click a webelement
##
__ELEMENT_CLICK__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${base_url}/session/${session_id}/element/${element_id}/click" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get the element tag name
##
__ELEMENT_GET_TAG_NAME__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${base_url}/session/${session_id}/element/${element_id}/name")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get the text from webelement
##
__ELEMENT_GET_TEXT__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${base_url}/session/${session_id}/element/${element_id}/text")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to check if element is selected
##
__ELEMENT_IS_SELECTED__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${base_url}/session/${session_id}/element/${element_id}/selected")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to check if element is enabled
##
__ELEMENT_IS_ENABLED__() {
  local base_url=$1
  local session_id=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${base_url}/session/${session_id}/element/${element_id}/enabled")
  __HANDLE_VALUE_RESPONSE__ "$response"
}


##
## Get element location and size
##
function __ELEMENT_GET_RECT__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local element_id=$3
  local value="$4"

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/element/${element_id}/rect")
  __HANDLE_DYNAMIC_KEY_RESPONSE__ "$response" "$4"
}

##
## Get screenshot of the element
##
function __ELEMENT_GET_SCREENSHOT__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local element_id=$3

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/element/${element_id}/screenshot")
  __HANDLE_VALUE_RESPONSE__ "$response"
}
