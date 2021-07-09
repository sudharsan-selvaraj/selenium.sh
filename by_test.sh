. selenium.sh
. packages/webdriver-manager/webdriver_manager.sh

webdrivermanager --browser "firefox"
driver=$(FirefoxDriver)
$driver.get "https://www.google.com"

search_input=$($driver.findElement "$(ByCssSelector '[action=\"/search\"]')" "$(ByName "q")")

search_inputs=$($driver.findElements "$(ByTagName "a")")
echo $($($search_inputs.get 24).id)
echo $($search_inputs.size)

div_element=$(
  $driver.findElements "$(ByTagName "div")"
)

anchor_elements=$($($div_element.get 0).findElements "$(ByTagName "a")")

echo $($($anchor_elements.get "0").getAttribute "src")

echo $(
  $(
    $(
      $($div_element.get 5).findElements "$(ByTagName "a")"
    ).get 1
  ).getAttribute "class"
)

$($driver.findElement "$(ByName "q")").sendKeys "TestNinja"
echo $($($driver.findElement "$(ByTagName "img")").getAttribute "src")
$driver.quit
