. "../bootstrap.sh"

cache_dir="${HOME}/.cache/selenium-sh"

test_webdriver_manager_chrome_driver() {
  rm -rf "${cache_dir}"
  assert_equals "${CHROME_DRIVER_PATH}" ""
  webdrivermanager --browser "chrome"
  assert_equals "${CHROME_DRIVER_PATH}" "${cache_dir}/chrome/91.0.4472.101/chromedriver"
}

test_webdriver_manager_firefox_driver() {
  rm -rf "${cache_dir}"
  assert_equals "${FIREFOX_DRIVER_PATH}" ""
  webdrivermanager --browser "firefox"
  assert_equals "${FIREFOX_DRIVER_PATH}" "${cache_dir}/firefox/0.29.0/geckodriver"
}
