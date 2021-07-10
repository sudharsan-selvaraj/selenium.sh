#####################################################################################
#                                COMMON COMMANDS                                    #
#####################################################################################
__FIND_ELEMENT__() {
  local selenium_address=$1
  local session_id=$2
  local search_context=$3
  local endpoint="${search_context}/element"

  for ((n = 4; n <= $#; n++)); do
    local response=$(__EXECUTE_WD_COMMAND__ "POST" "$endpoint" "${!n}")
    __CHECK_AND_THROW_ERROR__ "$response"
    local element_ref=$(__HANDLE_FIND_ELEMENT_RESPONSE__ $response)
    local element_id=$(echo "$element_ref" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\2/g')
    endpoint="${search_context}/element/${element_id}/element"
  done

  echo "__WEB_ELEMENT__ ${selenium_address} ${session_id} ${element_id} "
}

__FIND_ELEMENTS__() {
  local selenium_address=$1
  local session_id=$2
  local search_context=$3
  local by=$4

  local endpoint="${search_context}/elements"
  local response=$(__EXECUTE_WD_COMMAND__ "POST" "$endpoint" "${by}")
  __CHECK_AND_THROW_ERROR__ "$response"
  local element_ids=$(echo "$response" | "$jq" -r '.value[] | to_entries[] | "[" + (.key|tostring) + "=" + .value + "]"')
  __PROCESS_RESPONSE__ "__WEB_ELEMENTS__ ${selenium_address} ${session_id} $(echo $element_ids  | tr '\n' ' ') [end] "

}

#######################################################################################
#                                HELPER METHODS                                       #
#######################################################################################

__SHOULD_PRINT_RESPONSE__() {
  local SUBSHELL_ID=$(exec sh -c 'echo "$PPID"')

  if [ "$BASH_SUBSHELL" -gt 0 ] && [ "$SUBSHELL_ID" != ${__TRY_CATCH_SUBSHELL_ID__} ]; then
    return 1
  else
    return 0
  fi
}

__PROCESS_RESPONSE__() {
  __SHOULD_PRINT_RESPONSE__
  if [ "$?" == 1 ]; then
    echo "$1"
  fi
}

__HANDLE_VALUE_RESPONSE__() {
  __CHECK_AND_THROW_ERROR__ "$1"
  __PROCESS_RESPONSE__ "$(echo "$1" | "$jq" -r '.value')"
}

__HANDLE_FIND_ELEMENT_RESPONSE__() {
  __PROCESS_RESPONSE__ "$(echo "$1" | "$jq" -r '.value | to_entries | map("[\(.key)=\(.value)]") | .[] ')"
}

__HANDLE_TIMEOUT_RESPONSE__() {
  __CHECK_AND_THROW_ERROR__ "$1"
  __PROCESS_RESPONSE__ "$(echo "$1" | "$jq" -r '.value.'$2'')"
}

#######################################################################################
#                               HTTP REQUEST WRAPPER                                  #
#######################################################################################

__EXECUTE_WD_COMMAND__() {
  local http_method=$1
  local url=$2
  local body=$3

  local response=''
  local errorFile=$(mktemp)
  case "$http_method" in
  "GET")
    response="$(HTTP_GET "$url" 2>"$errorFile")"
    ;;
  "DELETE")
    response="$(HTTP_DELETE "$url" 2>"$errorFile")"
    ;;
  "POST")
    response="$(HTTP_POST "$url" "$body" 2>"$errorFile")"
    ;;
  "PATCH")
    response="$(HTTP_PATCH "$url" "$body" 2>"$errorFile")"
    ;;
  esac

  if [ "$?" != "0" ]; then
    echo "__EXCEPTION__ $EXCEPTION EXCEPTION \"$(cat $errorFile)\" [end] "
  fi
  echo "$response"
}
