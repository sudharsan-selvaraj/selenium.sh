. "$(cd "$(dirname "${BASH_SOURCE[0]}")/../../src/" &>/dev/null && pwd)/selenium.sh"

webdrivermanager --browser "chrome"

function main() {
  local driver=$(ChromeDriver)
  $driver.get "https://www.google.com"
  local search_input=$($driver.find_element "$(by_name "q")")
  $search_input.send_keys "TestNinja"
  echo "Entered search string: $($driver.execute_script "return arguments[0].value" "$($search_input.get_element)")"

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
}

main
