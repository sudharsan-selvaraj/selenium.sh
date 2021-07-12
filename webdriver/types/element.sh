##
## Runtime function that represents a webelement object
##
__WEB_ELEMENT__() {
  local selenium_address="$1"
  local session_id="$2"
  local element_ref="$3"
  local element_ref_id=$(echo "$element_ref" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\1/g')
  local element_id=$(echo "$element_ref" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\2/g')
  local method="$4"

  case "$method" in
  ".id")
    __PROCESS_RESPONSE__ "$element_id"
    ;;
  ".get_element")
    echo '{ "'${element_ref_id}'" : "'${element_id}'" }'
    ;;
  ".findElement")
    __ELEMENT_FIND_ELEMENT__ "$selenium_address" "$session_id" "$element_id" "${@:5}"
    ;;
  ".findElements")
    __ELEMENT_FIND_ELEMENTS__ "$selenium_address" "$session_id" "$element_id" "${@:5}"
    ;;
  '.sendKeys')
    local body="{ \"text\" : \"$5\"}"
    __ELEMENT_SEND_KEYS__ "$selenium_address" "$session_id" "$element_id" "$body"
    ;;
  '.getAttribute')
    __ELEMENT_GET_ATTRIBUTE__ "$selenium_address" "$session_id" "$element_id" "$5"
    ;;
  '.click')
    __ELEMENT_CLICK__ "$selenium_address" "$session_id" "$element_id"
    ;;
  '.getText')
    __ELEMENT_GET_TEXT__ "$selenium_address" "$session_id" "$element_id"
    ;;
  esac

}