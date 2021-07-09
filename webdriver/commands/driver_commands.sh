#!/usr/bin/env bash

source "${SELENIUM_SOURCE_DIR}/webdriver/commands/command_executor.sh"

########################################################################################
#                                WEBDRIVER METHODS                                     #
########################################################################################

##
## Method to open a new browser
##
__CREATE_DRIVER__() {
  local BASE_URL=$1
  local CAPABILITIES=$2

  echo "$CAPABILITIES" > response.txt
  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session" "${CAPABILITIES}")
  __CHECK_AND_THROW_ERROR__ "$response"
  __PROCESS_RESPONSE__ "__WEBDRIVER__ $BASE_URL $(echo "$response" | "$jq" -r '.value.sessionId') "
}

##
## Method to open the URL
##
__DRIVER_GET__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local URL=$3

  ## construct the post body
  local body="{ \"url\" : \"$URL\"}"
  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/url" "$body")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get the current page title
##
__DRIVER_GET_TITLE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/title")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get the current page source
##
__DRIVER_GET_PAGE_SOURCE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/source")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to refresh the current page
##
__DRIVER_PAGE_REFRESH__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/refresh" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method naviagte back
##
__DRIVER_NAVIGATE_BACK__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/back" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method navigate forward
##
__DRIVER_NAVIGATE_FORWARD__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/forward" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get screenshot
##
__DRIVER_GET_SCREENSHOT__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/screenshot")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to find element
##
__DRIVER_FIND_ELEMENT__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  __FIND_ELEMENT__ "${BASE_URL}" ${SESSION_ID} "${BASE_URL}/session/${SESSION_ID}" "${@:3}"
}

##
## Method to find element
##
__DRIVER_FIND_ELEMENTS__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  __FIND_ELEMENTS__ "${BASE_URL}" ${SESSION_ID} "${BASE_URL}/session/${SESSION_ID}" "${@:3}"
}

##
## Method to close the driver session
##
__DRIVER_QUIT__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "DELETE" "${BASE_URL}/session/${SESSION_ID}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}
