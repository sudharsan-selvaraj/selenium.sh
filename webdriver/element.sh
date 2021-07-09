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

##
## Runtime function that represents a webelement object
##
__WEB_ELEMENTS__() {
  local START_INDEX=2
  local args=("$@")

  local selenium_address="$1"
  local session_id="$2"
  local end_index=""

  for ((n = $START_INDEX; n <= $#; n++)); do
    if [[ ${args[n]} == "[end]"* ]]; then
      end_index=${n}
      break
    fi
  done

  local args_start_index=$((end_index + 1))
  local method="${args[args_start_index]}"
  local total_size=$((end_index - START_INDEX))

  case "$method" in
  ".get")
    local index=${args[$(echo $(($args_start_index + 1)))]}
    if [ "${index}" -ge "${total_size}" ]; then
      __CHECK_AND_THROW_ERROR__ "__EXCEPTION__ $EXCEPTION ELEMENT_INDEX_OUT_OF_BOUND 'Index: ${index}, Size: ${total_size}' [end] "
    fi
    local element_id=${args[$(echo $((index + START_INDEX)))]}
    __PROCESS_RESPONSE__ "__WEB_ELEMENT__ ${selenium_address} ${session_id} ${element_id} "
    ;;
  ".size")
    echo "$total_size"
    ;;

  esac

}
