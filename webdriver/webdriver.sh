##
## Runtime function that represents a webdriver object
##
__WEBDRIVER__() {
  local selenium_address="$1"
  local session_id="$2"
  local method="$3"

  case "$method" in
  ".get")
    local navigate_to_url="$4"
    __DRIVER_GET__ "$selenium_address" "$session_id" "$navigate_to_url"
    ;;
  ".getTitle")
    __DRIVER_GET_TITLE__ "$selenium_address" "$session_id"
    ;;
  ".getSource" | ".getPageSource")
    __DRIVER_GET_PAGE_SOURCE__ "$selenium_address" "$session_id"
    ;;
  ".refresh")
    __DRIVER_PAGE_REFRESH__ "$selenium_address" "$session_id"
    ;;
  ".back")
    __DRIVER_NAVIGATE_BACK__ "$selenium_address" "$session_id"
    ;;
  ".forward")
    __DRIVER_NAVIGATE_FORWARD__ "$selenium_address" "$session_id"
    ;;
  ".screenShot"  | ".getScreenShot")
    __DRIVER_GET_SCREENSHOT__ "$selenium_address" "$session_id"
    ;;
  ".findElement")
    __DRIVER_FIND_ELEMENT__ "$selenium_address" "$session_id" "${@:4}"
    ;;
  ".findElements")
    __DRIVER_FIND_ELEMENTS__ "$selenium_address" "$session_id" "${@:4}"
    ;;
  ".quit")
    __DRIVER_QUIT__ "$selenium_address" "$session_id"
    ;;

  esac

}
