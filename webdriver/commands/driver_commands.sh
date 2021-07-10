#!/usr/bin/env bash

source "${SELENIUM_SOURCE_DIR}/webdriver/commands/command_executor.sh"

########################################################################################
#                                WEBDRIVER METHODS                                     #
########################################################################################

##
## Method to open a new browser
##
function __CREATE_DRIVER__() {
  local BASE_URL=$1
  local CAPABILITIES=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session" "${CAPABILITIES}")
  __CHECK_AND_THROW_ERROR__ "$response"
  __PROCESS_RESPONSE__ "__WEBDRIVER__ $BASE_URL $(echo "$response" | "$jq" -r '.value.sessionId') "
}

##
## Method to open the URL
##
function __DRIVER_NAVIGATE_TO__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local URL=$3

  ## construct the post body
  local body="{ \"url\" : \"$URL\"}"
  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/url" "$body")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get the current URL
##
function __DRIVER_GET_URL__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/url")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get the current page title
##
function __DRIVER_GET_TITLE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/title")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get the current page source
##
function __DRIVER_GET_PAGE_SOURCE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/source")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to refresh the current page
##
function __DRIVER_PAGE_REFRESH__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/refresh" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method naviagte back
##
function __DRIVER_NAVIGATE_BACK__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/back" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method navigate forward
##
function __DRIVER_NAVIGATE_FORWARD__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/forward" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to get screenshot
##
function __DRIVER_GET_SCREENSHOT__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/screenshot")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to find element
##
function __DRIVER_FIND_ELEMENT__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  __FIND_ELEMENT__ "${BASE_URL}" ${SESSION_ID} "${BASE_URL}/session/${SESSION_ID}" "${@:3}"
}

##
## Method to find element
##
function __DRIVER_FIND_ELEMENTS__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  __FIND_ELEMENTS__ "${BASE_URL}" ${SESSION_ID} "${BASE_URL}/session/${SESSION_ID}" "${@:3}"
}

##
## Method to quit the driver session
##
function __DRIVER_QUIT__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "DELETE" "${BASE_URL}/session/${SESSION_ID}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Method to close the driver session
##
function __DRIVER_CLOSE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "DELETE" "${BASE_URL}/session/${SESSION_ID}/window")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

###############################################################################################
#                                   TIMEOUT METHODS                                           #
###############################################################################################

##
## Method to get the timeout details
##
function __DRIVER_GET_TIMEOUTS__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local timeout_name="$3"

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/timeouts")
  __HANDLE_TIMEOUT_RESPONSE__ "$response" "$timeout_name"
}

##
## Method to get the timeout details
##
function __DRIVER_SET_TIMEOUTS__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local timeout_name="$3"
  local timeout_value="$4"

  ## construct the post body
  local body='{ "'${timeout_name}'" : '${timeout_value}'}'
  echo "$body" >>response.txt
  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/timeouts" "${body}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

###############################################################################################
#                                    WINDOW METHODS                                           #
###############################################################################################

##
## Get current window handles
##
function __DRIVER_GET_WINDOW_HANDLE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/window")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Get current window handles
##
function __DRIVER_SWITCH_WINDOW__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local WINDOW_HANDLE="$3"

  local body='{ "handle" : "'$3'" }'
  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/window" "$body")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Make browser to fullscreen
##
function __DRIVER_WINDOW_FULLSCREEN__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/window/fullscreen" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Maximize browser window size
##
function __DRIVER_WINDOW_MAXIMIZE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/window/maximize" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}

##
## Minimize the browser window
##
function __DRIVER_WINDOW_MINIMIZE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/window/minimize" "{}")
  __HANDLE_VALUE_RESPONSE__ "$response"
}
