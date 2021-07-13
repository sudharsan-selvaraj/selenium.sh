export jq="/Users/sselvaraj/Desktop/iproov authentication/jq-osx-amd64"
. src/selenium.sh
. src/packages/webdriver-manager/webdriver_manager.sh

webdrivermanager --browser "chrome"

regex_test() {
  a="[safsdfsdf][sdfsdfsdfsdfsdf]"

  echo "$a" | sed 's/.*\[\([^]]*\)\].*\[\([^]]*\)\]/\1/g'
  echo "$a" | sed 's/.*\[\([^]]*\)\].*\[\([^]]*\)\]/\2/g'
}

regex_test2() {
  a="[safsdfsdf=sdfsdfsdfsdfsdf]"

  echo "$a" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\1/g'
  echo "$a" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\2/g'
}

find_element_response_test() {
  echo $(echo '{ "element-sdfds-dsfsdf" : "sdfsdfsdfsdfsdf" }' | "$jq" -r 'to_entries | map("[\(.key)=\(.value)]") | .[] ')
}

find_elements_response_test() {
  echo $(echo '[{ "element-sdfds-dsfsdf" : "sdfsdfsdfsdfsdf" }, { "element-ss-aa-aaaa" : "123123123123123123" }]' | "$jq" -r '.[] | to_entries[] | "[" + (.key|tostring) + "=" + .value + "]"')
}

test_timeout() {
  driver=$(ChromeDriver)
  echo $($driver.get_implicit_wait)
  echo $($driver.get_page_load_time)
  echo $($driver.get_script_timeout)

  $driver.set_implicit_wait 10000
  $driver.set_page_load_time 10000
  $driver.set_script_timeout 10000

  echo $($driver.get_implicit_wait)
  echo $($driver.get_page_load_time)
  echo $($driver.get_script_timeout)

  $driver.quit
}

test_url() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"
  echo $($driver.get_current_url)

  $driver.get "https://www.facebook.com"
  echo $($driver.get_current_url)
  $driver.quit
}

window_test() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"
  $driver.window.maximize
  $driver.window.minimize
  $driver.window.fullscreen
  $driver.quit
}

window_handle_test() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"
  local handle=$($driver.get_window_handle)
  echo "$handle"
  echo $($driver.switch_to.window "$handle2hgfhgfhgfhgfhgfh")
}

window_handles_test() {
  driver=$(ChromeDriver)
  $driver.get "https://the-internet.herokuapp.com/windows"
  $($driver.find_element "$(ByPartialLinkText "Click Here")").click
  local handle=$($driver.get_window_handles)
  echo "$($handle.size)"
  $driver.switch_to.window $($handle.get 2)
  echo "$($driver.getTitle)"
  $driver.quit
}

find_elements_test() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"

  elements=$($driver.find_elements "$(ByTagName "a")")
  echo $($elements.size)
  element=$($elements.get 24)
  for ((n = 0; n < $($elements.size); n++)); do
    echo "$($($elements.get "$n").get_text)"
  done
  $driver.quit
}

new_window_tab_test() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"
  $driver.open_new_window
  local handle=$($driver.get_window_handles)
  echo "$($handle.size)"

  $driver.open_new_tab
  local handle=$($driver.get_window_handles)
  echo "$($handle.size)"
}

window_position_test() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"

  $driver.set_window_rect '{ "x" : 45 , "y": 90 }'
  $driver.set_window_rect '{ "width" : 900 , "height": 700 }'

  echo "X = $($driver.get_window_x_position)"
  echo "Y = $($driver.get_window_y_position)"
  echo "width = $($driver.get_width)"
  echo "height = $($driver.get_height)"

  $driver.quit
}

frame_switch_test() {
  driver=$(ChromeDriver)
  $driver.get "https://the-internet.herokuapp.com/iframe"

  #echo $($driver.find_element "$(ByCssSelector "iframe")")

  $driver.switch_to.frame "$($($driver.find_element "$(ByCssSelector "iframe")").get_element)"
  echo $($($driver.find_element "$(ById "tinymce")").get_text)

  $driver.switch_to.default_content

  text=$($($driver.find_element "$(ById "tinymce")").get_text)
  echo $text
  $driver.quit
}

test_regex() {
  local number="3"
  if [[ $number =~ ^-?[0-9]+$ ]]; then
    echo "isNumber"
  fi
}

active_element_test() {
  driver=$(ChromeDriver)
  $driver.get "https://the-internet.herokuapp.com/iframe"

  echo $($($driver.get_active_element).get_text)

  $driver.quit
}

cookies_test() {
  driver=$(ChromeDriver)
  $driver.get "https://the-internet.herokuapp.com/iframe"
  echo $($($($driver.get_cookies).get 1).httpOnly)
  $driver.quit
}

execute_script_test() {
  driver=$(ChromeDriver)
  $driver.get "https://the-internet.herokuapp.com/iframe"
  body=$($driver.execute_script 'return document.querySelector(\"#page-footer\")')
  echo $($body.get_text)
}

execute_async_script_test() {
  driver=$(ChromeDriver)
  $driver.get "https://the-internet.herokuapp.com/iframe"
  body=$($driver.execute_async_script 'var callback=arguments[arguments.length-1]; return setTimeout(function(){ callback(document.querySelector(\"body\")) }, 3000)')
  echo $($body.get_text)
}

execute_async_script_test
