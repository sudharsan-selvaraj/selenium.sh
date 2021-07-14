# selenium.sh

## Installation

1. create a new directory or cd to any existing directory where that tests are present,

```sh
mkdir tests && cd tests
```

2. Run the below command in terminal

```sh
curl -sSL https://raw.githubusercontent.com/sudharsan-selvaraj/selenium.sh/main/install.sh | bash
```

This will create a new directory `selenium` and download the lib inside it

3. Create a script file `tests.sh` and copy the below script

```sh
#!/usr/bin/env bash

#import selenium
source selenium/selenium.sh

# it will download the respective chromedriver based on installed chrome version
webdrivermanager --browser "chrome"

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

4. Make sure to assign executable permission to the file

```shell
chmod +x script.sh
```

5. Run the script file

```shell
./script.sh
```