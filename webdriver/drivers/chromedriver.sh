function ChromeDriver() {

  local driver_path=${CHROME_DRIVER_PATH}
  local chrome_options='{}'
  ##
  ## Parse arguments
  ##
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -d | --driver_path)
      driver_path="$2"
      shift
      shift
      ;;
    -o | --chrome_options)
      if [[ "$2" == "{"* ]] && [[ "$2" == *"}" ]]; then
        chrome_options="$2"
      fi
      shift
      shift
      ;;
    esac
  done

  __chrome_driver_start__ "$driver_path" "$chrome_options"
}

function __chrome_driver_start__() {
  local driver_path="$1"
  local chrome_options="$2"
  local port=$(__get_free_port__)
  __start_driver__ "$driver_path" "$port"
  local capabilities='{ "capabilities": { "alwaysMatch" : { "browserName":"chrome" , "goog:chromeOptions" : '${chrome_options}' } }  }'
  echo "$(RemoteWebDriver http://localhost:${port} "$capabilities")"
}