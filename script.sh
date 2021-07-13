. src/selenium.sh
. src/packages/webdriver-manager/webdriver_manager.sh

webdrivermanager --browser "chrome"
webdrivermanager --browser "firefox"
#echo "${CHROME_DRIVER_PATH}"
#
#FirefoxDriver
echo "FirefoxDriver"
driver=$(FirefoxDriver)
#driver=$(ChromeDriver --chrome_options "{ \"args\": [\"--headless\"] }")
#driver=$(RemoteWebDriver --url "http://localhost:4444/wd/hub" --capabilities '{ "browserName": "chrome"  }')

$driver.get "https://www.google.com"
echo $($driver.get_title)

$driver.refresh

$driver.get "https://www.facebook.com"
echo $($driver.get_title)

$driver.back
echo $($driver.get_title)

echo $($($driver.find_element "$(ByCssSelector "a")").get_attribute "href")

$driver.forward
$driver.quit
