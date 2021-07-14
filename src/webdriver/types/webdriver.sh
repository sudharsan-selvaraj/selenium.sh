##
## Runtime function that represents a webdriver object
##
__WEBDRIVER__() {
  local selenium_address="$1"
  local session_id="$2"
  local method="$3"

  case "$method" in
  ".get_session_id") __DRIVER_GET_SESSION_ID__ "$2" ;;
  ".get") __DRIVER_NAVIGATE_TO__ "$selenium_address" "$session_id" "$4" ;;
  ".get_current_url") __DRIVER_GET_URL__ "$selenium_address" "$session_id" ;;
  ".get_title") __DRIVER_GET_TITLE__ "$selenium_address" "$session_id" ;;
  ".get_page_source") __DRIVER_GET_PAGE_SOURCE__ "$selenium_address" "$session_id" ;;
  ".get_screen_shot") __DRIVER_GET_SCREENSHOT__ "$selenium_address" "$session_id" ;;
  ".quit") __DRIVER_QUIT__ "$selenium_address" "$session_id" ;;
  ".close") __DRIVER_CLOSE__ "$selenium_address" "$session_id" ;;

    ###################################################################################
    #                            NAVIGATION METHODS                                   #
    ###################################################################################

  ".refresh") __DRIVER_PAGE_REFRESH__ "$selenium_address" "$session_id" ;;
  ".back") __DRIVER_NAVIGATE_BACK__ "$selenium_address" "$session_id" ;;
  ".forward") __DRIVER_NAVIGATE_FORWARD__ "$selenium_address" "$session_id" ;;

    ###################################################################################
    #                            ELEMENT METHODS                                      #
    ###################################################################################

  ".get_active_element") __DRIVER_GET_ACTIVE_ELEMENT__ "$selenium_address" "$session_id" ;;
  ".find_element") __DRIVER_FIND_ELEMENT__ "$selenium_address" "$session_id" "${@:4}" ;;
  ".find_elements") __DRIVER_FIND_ELEMENTS__ "$selenium_address" "$session_id" "${@:4}" ;;

    ###################################################################################
    #                               timeout METHODS                                      #
    ###################################################################################

  ".set_script_timeout") __DRIVER_SET_TIMEOUTS__ "$selenium_address" "$session_id" "script" "$4" ;;
  ".set_script_timeout") __DRIVER_GET_TIMEOUTS__ "$selenium_address" "$session_id" "script" ;;
  ".set_page_load_time") __DRIVER_SET_TIMEOUTS__ "$selenium_address" "$session_id" "pageLoad" "$4" ;;
  ".get_page_load_time") __DRIVER_GET_TIMEOUTS__ "$selenium_address" "$session_id" "pageLoad" ;;
  ".set_implicit_wait") __DRIVER_SET_TIMEOUTS__ "$selenium_address" "$session_id" "implicit" "$4" ;;
  ".get_implicit_wait") __DRIVER_GET_TIMEOUTS__ "$selenium_address" "$session_id" "implicit" ;;

    ###################################################################################
    #                               WINDOW METHODS                                    #
    ###################################################################################
  ".set_window_rect") __SET_WINDOW_RECT__ "$selenium_address" "$session_id" "$4" ;;
  ".get_window_x_position") __GET_WINDOW_RECT__ "$selenium_address" "$session_id" "x" ;;
  ".get_window_y_position") __GET_WINDOW_RECT__ "$selenium_address" "$session_id" "y" ;;
  ".get_width") __GET_WINDOW_RECT__ "$selenium_address" "$session_id" "width" ;;
  ".get_height") __GET_WINDOW_RECT__ "$selenium_address" "$session_id" "height" ;;
  ".open_new_tab") __DRIVER_CREATE_NEW_TAB__ "$selenium_address" "$session_id" ;;
  ".open_new_window") __DRIVER_CREATE_NEW_WINDOW__ "$selenium_address" "$session_id" ;;
  ".get_window_handle") __DRIVER_GET_WINDOW_HANDLE__ "$selenium_address" "$session_id" ;;
  ".get_window_handles") __DRIVER_GET_WINDOW_HANDLES__ "$selenium_address" "$session_id" ;;
  ".switch_to.window") __DRIVER_SWITCH_WINDOW__ "$selenium_address" "$session_id" "$4" ;;
  ".switch_to.frame") __DRIVER_SWITCH_FRAME__ "$selenium_address" "$session_id" "$4" ;;
  ".switch_to.default_content") __DRIVER_SWITCH_PARENT_FRAME__ "$selenium_address" "$session_id" ;;
  ".window.fullscreen") __DRIVER_WINDOW_FULLSCREEN__ "$selenium_address" "$session_id" ;;
  ".window.maximize") __DRIVER_WINDOW_MAXIMIZE__ "$selenium_address" "$session_id" ;;
  ".window.minimize") __DRIVER_WINDOW_MINIMIZE__ "$selenium_address" "$session_id" ;;

    ###################################################################################
    #                               COOKIE METHODS                                    #
    ###################################################################################
  ".get_cookies") __DRIVER_GET_COOKIES__ "$selenium_address" "$session_id" ;;
  ".get_cookie") __DRIVER_GET_COOKIE_BY_NAME__ "$selenium_address" "$session_id" "$4";;
  ".add_cookie") __DRIVER_ADD_COOKIE__ "$selenium_address" "$session_id" "$4";;
  ".delete_cookie") __DRIVER_DELETE_COOKIE__ "$selenium_address" "$session_id" "$4";;
  ".delete_cookies") __DRIVER_DELETE_COOKIES__ "$selenium_address" "$session_id";;

    ###################################################################################
    #                               ALERT METHODS                                    #
    ###################################################################################
  ".alert.accept") __DRIVER_ALERT_ACCEPT__ "$selenium_address" "$session_id" ;;
  ".alert.dismiss") __DRIVER_ALERT_DISMISS__ "$selenium_address" "$session_id" ;;
  ".alert.get_text") __DRIVER_ALERT_GET_TEXT__ "$selenium_address" "$session_id" ;;
  ".alert.set_text") __DRIVER_ALERT_SET_TEXT__ "$selenium_address" "$session_id" "$4";;

    ###################################################################################
    #                               SCRIPT METHODS                                    #
    ###################################################################################
  ".execute_script") __EXECUTE_SCRIPT__ "$selenium_address" "$session_id" "sync" "$4" "${@:5}";;
  ".execute_async_script") __EXECUTE_SCRIPT__ "$selenium_address" "$session_id" "async" "$4" "${@:5}";;

  esac

}
