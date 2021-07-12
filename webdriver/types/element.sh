##
## Runtime function that represents a webelement object
##
__WEB_ELEMENT__() {
  local selenium_address="$1"
  local session_id="$2"
  local element_ref="$3"
  local method="$4"

  local element_ref_id=$(echo "$element_ref" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\1/g')
  local element_id=$(echo "$element_ref" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\2/g')

  case "$method" in
  ".id") __PROCESS_RESPONSE__ "$element_id" ;;
  ".get_element") __PROCESS_RESPONSE__ '{ "'${element_ref_id}'" : "'${element_id}'" }' ;;
  '.get_tag_name') __ELEMENT_GET_TAG_NAME__ "$selenium_address" "$session_id" "$element_id" ;;
  '.get_text') __ELEMENT_GET_TEXT__ "$selenium_address" "$session_id" "$element_id" ;;
  '.get_attribute') __ELEMENT_GET_ATTRIBUTE__ "$selenium_address" "$session_id" "$element_id" "$5" ;;
  '.get_property') __ELEMENT_GET_PROPERTY__ "$selenium_address" "$session_id" "$element_id" "$5" ;;
  '.get_css_value') __ELEMENT_GET_CSS_VALUE__ "$selenium_address" "$session_id" "$element_id" "$5" ;;
  '.clear') __ELEMENT_CLEAR_VALUE__ "$selenium_address" "$session_id" "$element_id" ;;
  '.send_keys') __ELEMENT_SEND_KEYS__ "$selenium_address" "$session_id" "$element_id" "$5" ;;
  '.click') __ELEMENT_CLICK__ "$selenium_address" "$session_id" "$element_id" ;;
  '.is_selected') __ELEMENT_IS_SELECTED__ "$selenium_address" "$session_id" "$element_id" ;;
  '.is_enabled') __ELEMENT_IS_ENABLED__ "$selenium_address" "$session_id" "$element_id" ;;
  '.get_x_position') __ELEMENT_GET_RECT__ "$selenium_address" "$session_id" "$element_id" "x" ;;
  '.get_y_position') __ELEMENT_GET_RECT__ "$selenium_address" "$session_id" "$element_id" "y" ;;
  '.get_height') __ELEMENT_GET_RECT__ "$selenium_address" "$session_id" "$element_id" "height" ;;
  '.get_width') __ELEMENT_GET_RECT__ "$selenium_address" "$session_id" "$element_id" "width" ;;
  '.get_screenshot') __ELEMENT_GET_SCREENSHOT__ "$selenium_address" "$session_id" "$element_id" ;;
  ".find_element") __ELEMENT_FIND_ELEMENT__ "$selenium_address" "$session_id" "$element_id" "${@:5}" ;;
  ".find_elements") __ELEMENT_FIND_ELEMENTS__ "$selenium_address" "$session_id" "$element_id" "${@:5}" ;;
  esac

}
