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
     echo $($driver.get_session_id) # prints 1dkb213b8bar5nm20sd6aaaskjasdhd7
     ```
    </details>

- **get_current_url**
  <details>
    <summary>Returns the current url</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_current_url) #prints https://www.google.com
     ```
    </details>

- **get_title**
  <details>
    <summary>Returns the current title of the tab</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_title) #prints Google
     ```
    </details>

- **get_page_source**
  <details>
    <summary>Returns the HTML page source</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_page_source) #prints Google
     ```
    </details>

- **get_screen_shot**
  <details>
    <summary>Returns the screen shot of the current webpage in base64 format</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     echo $($driver.get_screen_shot) # prints base64 string
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

- **forward**
  <details>
    <summary>Navigates to the next webpage from the history</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
     $driver.get "https://www.github.com"
     
     $driver.back
     echo $($driver.get_current_url) #prints https://www.google.com 
     
     $driver.forward  
     echo $($driver.get_current_url) #prints https://www.github.com
     ```
    </details>

- **quit**
  <details>
    <summary>Quit the current webdriver session</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
      
     $driver.quit 
     ```
    </details>

- **close**
  <details>
    <summary>Close the current active window/tab</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
      
     $driver.close 
     ```
    </details>

- **find_element**
  <details>
    <summary>Returns the first found element for the given locator</summary>
      </br>

    ```shell 
     driver=$(ChromeDriver)    
     $driver.get "https://www.google.com"
  
     search_text_box=$driver.find_element "$(by_name "q")"    
     search_text_box.send_keys "Test Ninja" 
     $driver.close 
     ```
     </br>
    It's also possible to chaain multiple locators

    ```shell
    driver=$(ChromeDriver)    
   $driver.get "https://www.google.com"

   footer_gmail_link=$driver.find_element "$(by_id "footer")" "$(by_link_text "Gmail")"    
  footer_gmail_link.click 
  $driver.close 
    ```
    </details>

- **find_elements**
  <details>
    <summary>Returns multiple elements found using given locator</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    anchor_elements=$driver.find_elements "$(by_tagname "a")"
    
    echo $(anchor_elements.size)
  
    for ((i = 0; i < $($anchor_elements.size); i++)); 
    do
      echo "$($($anchor_elements.get "$i").get_attribute "href")"
    done   
    $driver.close 
     ```
    </details>

- **get_active_element**
  <details>
    <summary>Returns the currect element thats in focus</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
  
    echo $($driver.get_active_element).get_text 
  
    $driver.close 
     ```
    </details>

- **set_window_rect**
  <details>
    <summary>Change window position and size</summary>
      </br>

    **Change window position:**
    ```shell 
      driver=$(ChromeDriver)    
      $driver.get "https://www.google.com"
      
      $driver.set_window_rect '{ "x": 100, "y": 200 }'
      
      $driver.close 
     ```
    **Change window size:**
    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    $driver.set_window_rect '{ "width": 1024, "height": 700 }'
    
    $driver.close 
     ```
    </details>

- **get_window_x_position**
  <details>
    <summary>Returns current X position of the window</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    $driver.set_window_rect '{ "x": 100, "y": 200 }'
    echo $driver.get_window_x_position # prints 100
  
    $driver.close
     ```
    </details>

- **get_window_y_position**
  <details>
    <summary>Returns current Y position of the window</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    $driver.set_window_rect '{ "x": 100, "y": 200 }'
  
    echo $driver.get_window_y_position # prints 200
  
    $driver.close
     ```
    </details>

- **get_width**
  <details>
    <summary>Returns current width of the window</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    $driver.set_window_rect '{ "width": 1024, "height": 700 }'
    echo $driver.get_width #prints 1024
  
    $driver.close
     ```
    </details>

- **get_height**
  <details>
    <summary>Returns current height of the window</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    $driver.set_window_rect '{ "width": 1024, "height": 700 }'
    echo $driver.get_height #prints 700
  
    $driver.close
     ```
    </details>

- **open_new_tab**
  <details>
    <summary>Opens new Tab on the same window</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    $driver.open_new_tab
    echo $($driver.get_window_handles).size #prints 2
  
    $driver.close
     ```
    </details>

- **open_new_window**
  <details>
    <summary>Opens a new window</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    $driver.open_new_window
    echo $($driver.get_window_handles).size #prints 2
  
    $driver.close
     ```
    </details>

- **get_window_handle**
  <details>
    <summary>Returns the window handle of the current tab</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    echo $driver.get_window_handle
  
    $driver.close
     ```
    </details>

- **get_window_handles**
  <details>
    <summary>Returns the window handle of the current tab</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    $driver.open_new_tab
    $driver.open_new_tab
    
    window_handles=$driver.get_window_handles
    echo $window_handles.size #prints 3
     
    for((i=0;i<$window_handles.size);i++)); do
      echo $($window_handles.get "${i}")
    done
   
    $driver.close
     ```
    </details>

- **switch_to.window**
  <details>
    <summary>Switch the focus to specific window handle</summary>
      </br>

    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    
    $driver.open_new_tab
    $driver.open_new_tab
    
    window_handles=$driver.get_window_handles
    echo $window_handles.size #prints 3
     
    for((i=0;i<$window_handles.size);i++)); do
      $driver.switch_to.window "$($window_handles.get "${i}")"
      echo "$($driver.get_title)"
    done
   
    $driver.close
     ```
    </details>

- **switch_to.frame**
  <details>
    <summary>Switch the focus to specific iframe</summary>
    </br>
    
  **By Frame index:**
  
    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.sitewithiframe.com"
    
    # switches to first iframe
    $driver.switch_to.frame 0
    
    $driver.close
     ```
  
  **By Frame element:**
  ```shell 
  driver=$(ChromeDriver)    
  $driver.get "https://www.sitewithiframe.com"
  
  iframe_ele="$($driver.find_element "$(by_id "frame1")")"
  $driver.switch_to.frame "$(iframe_ele.get_element)"
  
  $driver.close
   ```
  </details>

- **.switch_to.default_content**
  <details>
    <summary>Switch the focus to parent frame/window</summary>
    </br>
  
    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.sitewithiframe.com"
    
    # switches to first iframe
    $driver.switch_to.frame 0
    
    #
    # perform some operation
    #
    
  $driver.switch_to.default_content
    $driver.close
     ```
  </details>

- **window.fullscreen**
  <details>
    <summary>Activates fullscreen mode</summary>
    </br>
  
    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    $driver.window.fullscreen
     ```
  </details>

- **window.maximize**
  <details>
    <summary>Maximize the current window to desktop width and height</summary>
    </br>
  
    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    $driver.window.maximize
     ```
  </details>

- **window.minimize**
  <details>
    <summary>Minimizes the current window</summary>
    </br>
  
    ```shell 
    driver=$(ChromeDriver)    
    $driver.get "https://www.google.com"
    $driver.window.minimize
     ```
  </details>

```
Other Api's are yet to be documented
```

## element

```
Api's are yet to be documented
```