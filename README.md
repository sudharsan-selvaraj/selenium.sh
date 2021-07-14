# selenium.sh

## Example

```sh
#!/usr/bin/env bash

#import selenium
source /lib/selenium.sh

# it will download the respective chromedriver based on installed chrome version
webdrivermanager --browser "chrome"

#create an instance of chromedriver
driver=$(ChromeDriver)

$driver.get "https://www.google.com"

search_input=$($driver.find_element "$(by_name "q")")

$search_input.send_keys "TestNinja"

entered_text=$($driver.execute_script "return arguments[0].value" "$($search_input.get_element)")

echo "Entered search string: $entered_text"

# Support for try/catch specific webdriver exception
try
(
  begin
  
  $driver.find_element "$(by_name "invalid name")"
)
catch || {
  case $exception_code in
    $NO_SUCH_ELEMENT_EXCEPTION)
      echo "No such element found ${exit_code}"
    ;;
  esac
}

$driver.quit
```

## Installation

```
Will be added soon
```