. "bootstrap.sh"
webdrivermanager --browser "chrome"

declare driver=''

setup() {
  driver=$(ChromeDriver)
}

teardown() {
  $driver.quit
}

############################################################
#                     ACTUAL TESTS                         #
############################################################
test_driver_get() {
  local url="https://the-internet.herokuapp.com/"
  $driver.get "$url"

  assert_equals "$url" "$($driver.get_current_url)"
}

test_driver_get_title() {
  local url="https://the-internet.herokuapp.com/"
  $driver.get "$url"

  assert_equals "The Internet" "$($driver.get_title)"
}

test_driver_get_session_id() {
  local url="https://the-internet.herokuapp.com/"

  assert_not_equals "" "$($driver.get_session_id)"
}

test_get_page_source() {
  local html='<html><head><title>MyApp</title></head><body><h1>Hello world</h1></body></html>'
  local url="data:text/html;charset=utf-8,${html}"

  $driver.get "$url"

  assert_equals "$html" "$($driver.get_page_source)"
}
