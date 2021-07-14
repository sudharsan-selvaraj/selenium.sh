. selenium.sh
. packages/webdriver-manager/webdriver_manager.sh

webdrivermanager --browser "firefox"
webdrivermanager --browser "chrome"
#driver=$(RemoteWebDriver --url "http://localhost:4444/wd/hub" --capabilities '{ "browserName" : "chrome" }')
driver=$(ChromeDriver)
$driver.get "https://www.google.com"

search_input=$($driver.find_element "$(ByCssSelector '[action=\"/search\"]')" "$(ByName "q")")

search_inputs=$($driver.find_elements "$(ByTagName "a")")
echo $($($search_inputs.get 24).id)
echo $($search_inputs.size)

div_element=$(
  $driver.find_elements "$(ByTagName "div")"
)

anchor_elements=$($($div_element.get 0).find_elements "$(ByTagName "a")")

echo $($($anchor_elements.get "0").get_attribute "src")

echo $(
  $(
    $(
      $($div_element.get 5).find_elements "$(ByTagName "a")"
    ).get 1
  ).get_attribute "class"
)

$($driver.find_element "$(ByName "q")").sendKeys "TestNinja"
echo $($($driver.find_element "$(ByTagName "img")").get_attribute "src")
$driver.quit
