########################################################
#                     CONSTANTS                       #
########################################################
export RED='\033[0;31m'
export NC='\033[0m' # No Color

#########################################################
#                    EXCEPTION CODES                    #
#########################################################
export SCRIPT_TIMEOUT_EXCEPTION=79
export ELEMENT_CLICK_INTERCEPTED_EXCEPTION=80
export ELEMENT_NOT_SELECTABLE_EXCEPTION=81
export ELEMENT_NOT_INTERACTABLE_EXCEPTION=82
export ELEMENT_NOT_VISIBLE_EXCEPTION=83
export IME_ACTIVATION_FAILED_EXCEPTION=84
export IME_NOT_AVAILABLE_EXCEPTION=85
export INVALID_ARGUMENT_EXCEPTION=86
export INVALID_COOKIE_DOMAIN_EXCEPTION=87
export INVALID_COORDINATES_EXCEPTION=88
export INVALID_ELEMENT_STATE_EXCEPTION=89
export INVALID_SELECTOR_EXCEPTION=90
export INVALID_SELECTOR_EXCEPTION=91
export INVALID_SELECTOR_EXCEPTION=92
export JAVASCRIPT_EXCEPTION=93
export UNSUPPORTED_COMMAND_EXCEPTION=94
export UNSUPPORTED_COMMAND_EXCEPTION=95
export MOVE_TARGET_OUT_OF_BOUNDS_EXCEPTION=96
export NO_ALERT_PRESENT_EXCEPTION=97
export NO_SUCH_COOKIE_EXCEPTION=98
export NO_SUCH_ELEMENT_EXCEPTION=99
export NO_SUCH_FRAME_EXCEPTION=100
export NO_SUCH_SESSION_EXCEPTION=101
export NO_SUCH_WINDOW_EXCEPTION=102
export SESSION_NOT_CREATED_EXCEPTION=103
export STALE_ELEMENT_REFERENCE_EXCEPTION=104
export TIMEOUT_EXCEPTION=105
export INVALID_SELECTOR_EXCEPTION=106
export SCREENSHOT_EXCEPTION=107
export UNABLE_TO_SET_COOKIE_EXCEPTION=108
export UNHANDLED_ALERT_EXCEPTION=109
export WEB_DRIVER_EXCEPTION=110
export UNSUPPORTED_COMMAND_EXCEPTION=111

#####################################################################
#                     W3C Exception MAP                             #
#####################################################################

declare W3C_EXCEPTION='{
  "script_timeout": "79",
  "element_click_intercepted": "80",
  "element_not_selectable": "81",
  "element_not_interactable": "82",
  "element_not_visible": "83",
  "unsupported_operation": "95",
  "invalid_argument": "86",
  "invalid_cookie_domain": "87",
  "invalid_element_coordinates": "88",
  "invalid_element_state": "89",
  "invalid_selector": "106",
  "javascript_error": "93",
  "unknown_method": "94",
  "move_target_out_of_bounds": "96",
  "no_such_alert": "97",
  "no_such_cookie": "98",
  "no_such_element": "99",
  "no_such_frame": "100",
  "invalid_session_id": "101",
  "no_such_window": "102",
  "session_not_created": "103",
  "stale_element_reference": "104",
  "timeout": "105",
  "unable_to_capture_screen": "107",
  "unable_to_set_cookie": "108",
  "unexpected_alert_open": "109",
  "unknown_error": "110",
  "unknown_command": "111"
}'

__GET_WEBDRIVER_ERRORCODE__() {
  ## W3C error code contains " " between the words.
  ## replace the " " with "_" and identify the error code from the JSON
  ##
  ## $1 holds the error message from the wedriver response.

  W3C_CODE=$(echo "$1" | sed 's/ /_/g')
  echo $(echo $W3C_EXCEPTION | "$jq" -r '.'$W3C_CODE'')
}

__CHECK_AND_THROW_ERROR__() {
  local JSON_RESPONSE=$1
  local ERROR=$(echo $JSON_RESPONSE | "$jq" -r '.value.error')
  ##
  ## Check if webdriver response contains error key.
  ## if, error is not present "jq" will return "null"
  ##
  if [ "$ERROR" != "null" ]; then
    ##
    ## Obtain numeric error code from webdriver error code
    ##
    local ERROR_CODE=$(__GET_WEBDRIVER_ERRORCODE__ "$ERROR")
    local ERROR_MESSAGE=$(echo $JSON_RESPONSE | "$jq" -r '.value.message')

    ##
    ## Get the subshell process ID in which the current code is getting executed
    ##
    local SUBSHELL_ID=$(exec sh -c 'echo "$PPID"')

    ##
    ## $BASH_SUBSHELL command is used to check if the current execution is inside subshell or not
    ## if $BASH_SUBSHELL is 0, then the execution is not inside the subshell
    ##
    if [ "$BASH_SUBSHELL" -gt 0 ] && [ "$SUBSHELL_ID" != ${__TRY_CATCH_SUBSHELL_ID__} ]; then
      ##
      ## If the execution is inside the sub shell, then construct the exception string which will throw error when invoked further
      ##
      exe_command=(__EXCEPTION__ $ERROR_CODE $(echo "$ERROR" | sed 's/ /_/g') $ERROR_MESSAGE)
      echo "${exe_command[@]} "
    else
      ##
      ## If the execution is not inside the sub shell, directly raise the execption
      ##
      __EXCEPTION__ $ERROR_CODE "$(echo "$ERROR" | sed 's/ /_/g')" "$ERROR_MESSAGE"
    fi
    throw $ERROR_CODE
  fi
}

__GET_STACK_TRACE__() {
  STACK=""
  local i message="${1:-""}"
  local stack_size=${#FUNCNAME[@]}
  # to avoid noise we start with 1 to skip the get_stack function
  for ((i = 1; i < $stack_size; i++)); do
    local func="${FUNCNAME[$i]}"
    [ x$func = x ] && func=MAIN
    local linen="${BASH_LINENO[$((i - 1))]}"
    local src="${BASH_SOURCE[$i]}"
    [ x"$src" = x ] && src=non_file_source

    STACK+=$'\n'"   at: "$func" "$src:$linen""
  done
  STACK="${message}${STACK} "
  echo "$STACK"
}

__EXCEPTION__() {

  ##
  ## $1 => Numeric exit code for the exception
  ## $2 => Exception name
  ## $3 => Exception message from API response
  ##
  ## since the exception message is in string format which contains " " special character,
  ## it will get split  and will be passed as individual parameter.
  ## So, we need to construct the message back by looping through the parameters.
  ##

  local message=""
  for ((n = 3; n <= ("$#"); n++)); do
    message="${message} ${!n}"
  done
  if [ "$__inside_try__" == "false" ]; then
    ##
    ## If not executed inside try catch, print the error message in console
    ##
    printf "${RED}$(echo "$2" | tr '[a-z]' '[A-Z]')_EXCEPTION: $message ${NC}"
    printf "$(__GET_STACK_TRACE__)"
  fi
  throw $1
}
