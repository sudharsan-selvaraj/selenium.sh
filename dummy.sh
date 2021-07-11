export jq="/Users/sselvaraj/Desktop/iproov authentication/jq-osx-amd64"
. selenium.sh
. packages/webdriver-manager/webdriver_manager.sh

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
  echo $($driver.getImplicitWait)
  echo $($driver.getPageLoadTime)
  echo $($driver.getScriptTimeout)

  $driver.setImplicitWait 10000
  $driver.setPageLoadTime 10000
  $driver.setScriptTimeout 10000

  echo $($driver.getImplicitWait)
  echo $($driver.getPageLoadTime)
  echo $($driver.getScriptTimeout)

  $driver.quit
}

test_url() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"
  echo $($driver.getCurrentUrl)

  $driver.get "https://www.facebook.com"
  echo $($driver.getCurrentUrl)
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
  local handle=$($driver.getWindowHandle)
  echo "$handle"
  echo $($driver.switchTo.window "$handle2hgfhgfhgfhgfhgfh")
}

find_elements_test() {
  driver=$(ChromeDriver)
  $driver.get "https://www.google.com"

  elements=$($driver.findElements "$(ByTagName "a")")
  echo $($elements.size)
  element=$($elements.get 24)
  for ((n = 0; n < $($elements.size); n++)); do
    echo "$($($elements.get "$n").getText)"
  done
  $driver.quit
}

find_elements_test
