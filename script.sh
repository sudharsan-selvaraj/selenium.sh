. selenium.sh
. packages/webdriver-manager/webdriver_manager.sh

webdrivermanager --browser "chrome"
webdrivermanager --browser "firefox"
#echo "${CHROME_DRIVER_PATH}"
#
#FirefoxDriver
echo "FirefoxDriver"
#driver=$(FirefoxDriver)
#driver=$(ChromeDriver --chrome_options "{ \"args\": [\"--headless\"] }")
driver=$(RemoteWebDriver --url "http://localhost:4444/wd/hub" --capabilities '{ "browserName": "chrome"  }')

$driver.get "https://www.google.com"
echo $($driver.getTitle)

$driver.refresh

$driver.get "https://www.facebook.com"
echo $($driver.getTitle)

$driver.back
echo $($driver.getTitle)

$driver.forward
$driver.quit
