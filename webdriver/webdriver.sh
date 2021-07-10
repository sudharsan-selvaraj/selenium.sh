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
    __DRIVER_NAVIGATE_TO__ "$selenium_address" "$session_id" "$navigate_to_url"
    ;;
  ".getCurrentUrl")
    __DRIVER_GET_URL__ "$selenium_address" "$session_id"
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
  ".screenShot" | ".getScreenShot")
    __DRIVER_GET_SCREENSHOT__ "$selenium_address" "$session_id"
    ;;
  ".findElement")
    __DRIVER_FIND_ELEMENT__ "$selenium_address" "$session_id" "${@:4}"
    ;;
  ".findElements")
    __DRIVER_FIND_ELEMENTS__ "$selenium_address" "$session_id" "${@:4}"
    ;;
  ".setScriptTimeout")
    __DRIVER_SET_TIMEOUTS__ "$selenium_address" "$session_id" "script" "$4"
    ;;
  ".getScriptTimeout")
    __DRIVER_GET_TIMEOUTS__ "$selenium_address" "$session_id" "script"
    ;;
  ".setPageLoadTime")
    __DRIVER_SET_TIMEOUTS__ "$selenium_address" "$session_id" "pageLoad" "$4"
    ;;
  ".getPageLoadTime")
    __DRIVER_GET_TIMEOUTS__ "$selenium_address" "$session_id" "pageLoad"
    ;;
  ".setImplicitWait")
    __DRIVER_SET_TIMEOUTS__ "$selenium_address" "$session_id" "implicit" "$4"
    ;;
  ".getImplicitWait")
    __DRIVER_GET_TIMEOUTS__ "$selenium_address" "$session_id" "implicit"
    ;;

    ###################################################################################
    #                               WINDOW METHODS                                    #
    ###################################################################################
  ".getWindowHandle")
    __DRIVER_GET_WINDOW_HANDLE__ "$selenium_address" "$session_id"
    ;;
  ".switchTo.window")
    __DRIVER_SWITCH_WINDOW__ "$selenium_address" "$session_id" "$4"
    ;;
  ".window.fullscreen")
    __DRIVER_WINDOW_FULLSCREEN__ "$selenium_address" "$session_id"
    ;;
  ".window.maximize")
    __DRIVER_WINDOW_MAXIMIZE__ "$selenium_address" "$session_id"
    ;;
  ".window.minimize")
    __DRIVER_WINDOW_MINIMIZE__ "$selenium_address" "$session_id"
    ;;

  ".quit")
    __DRIVER_QUIT__ "$selenium_address" "$session_id"
    ;;
  ".close")
    __DRIVER_CLOSE__ "$selenium_address" "$session_id"
    ;;
  esac

}
