. "../bootstrap.sh"

#################################################################################
#                              CHROME DRIVER                                    #
#################################################################################
test_chrome_driver_creation_error() {
  driver=$(ChromeDriver)
  assert_equals "$driver" '__EXCEPTION__ 255 CHROME_DRIVER_NOT_FOUND "Kindly add the path chrome driver in CHROME_DRIVER_PATH environment variable"'
}

test_chrome_driver_creation() {

  webdrivermanager --browser "chrome"

  driver=$(ChromeDriver)
  local is_chrome=$($driver.execute_script 'return new RegExp(/chrome|chromium|crios/i).test(window.navigator.userAgent)')
  assert_equals $is_chrome "true"

  $driver.quit
}

#################################################################################
#                             FIREFOX DRIVER                                    #
#################################################################################
test_firefox_driver_creation_error() {
  driver=$(FirefoxDriver)
  assert_equals "$driver" '__EXCEPTION__ 255 FIREFOX_DRIVER_NOT_FOUND "Kindly add the path to firefox driver in FIREFOX_DRIVER_PATH environment variable"'
}

test_firefox_driver_creation() {

  webdrivermanager --browser "firefox"

  driver=$(FirefoxDriver)
  local is_firefox=$($driver.execute_script 'return new RegExp(/firefox|fxios/i).test(window.navigator.userAgent)')
  assert_equals "$is_firefox" "true"

  $driver.quit
}

#################################################################################
#                             REMOTE WEBDRIVER                                    #
#################################################################################
test_remote_driver_creation_error() {
  driver=$(RemoteWebDriver)
  assert_equals "$driver" "__EXCEPTION__ 255 EXCEPTION 'Kindly pass the selenium address using --url to start the remote webdriver session' [end]"

  driver=$(RemoteWebDriver -u "http://localhost:4444/wd/hub")
  assert_equals "$driver" "__EXCEPTION__ 255 EXCEPTION 'Kindly pass the capabilities using --capabilities to start the remote webdriver session' [end]"

  driver=$(RemoteWebDriver -u "http://localhost:4444/wd/hub" -c '{ "browserName" : "chrome" }')
  assert_not_equals "" "$($driver.get_session_id)"

  local is_chrome=$($driver.execute_script 'return new RegExp(/chrome|chromium|crios/i).test(window.navigator.userAgent)')
  assert_equals $is_chrome "true"

  $driver.quit
}
