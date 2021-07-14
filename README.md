# selenium.sh

- [Installation](#installation)
- [API](#api)
    - [driver](#driver)
    - [webelement](#element)

## Installation

1. create a new directory or cd to any existing directory where the tests are present,

```sh
mkdir tests && cd tests
```

2. Run the below command in terminal

```sh
curl -sSL https://raw.githubusercontent.com/sudharsan-selvaraj/selenium.sh/main/install.sh | bash
```

This will create a new directory `selenium` and downloads the lib into it

3. Create a script file `tests.sh` and save it with the below content

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

# API

## driver

- **get**
    <details>
    <summary>Navigates to given URL</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)     
      
     $driver.get "https://www.google.com"
     ```

    </details>

- **get_session_id**
  <details>
    <summary>Returns the current session id</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)     
     echo $($driver.get_session_id) // 1dkb213b8bar5nm20sd6aaaskjasdhd7
     ```
    </details>

- **get_current_url**
  <details>
    <summary>Returns the current url</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_current_url) // https://www.google.com
     ```
    </details>

- **get_title**
  <details>
    <summary>Returns the current title of the tab</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_title) // Google
     ```
    </details>

- **get_page_source**
  <details>
    <summary>Returns the HTML page source</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_page_source) // Google
     ```
    </details>

- **get_screen_shot**
  <details>
    <summary>Returns the screen shot of the current webpage in base64 format</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_screen_shot) // base64 string
     ```
    </details>

- **refresh**
  <details>
    <summary>Reloads/refresh the current url</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     $driver.refresh
     ```
    </details>

- **back**
  <details>
    <summary>Navigates to the previously opened webpage from the history</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     $driver.get "https://www.github.com"
     $driver.back
     echo $($driver.get_current_url) // https://www.google.com
     ```
    </details>

- **back**
  <details>
    <summary>Navigates to the next webpage from the history</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     $driver.get "https://www.github.com"
     
     $driver.back
     echo $($driver.get_current_url) // https://www.google.com 
     
     $driver.forward  
     echo $($driver.get_current_url) // https://www.github.com
     ```
    </details>

```
Other Api's are yet to be documented
```
## element

```
Api's are yet to be documented
```