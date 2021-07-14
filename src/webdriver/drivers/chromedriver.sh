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

  if [ ! -f "$driver_path" ]; then
    __CHECK_AND_THROW_ERROR__ '__EXCEPTION__ '$EXCEPTION' CHROME_DRIVER_NOT_FOUND "Kindly add the path chrome driver in CHROME_DRIVER_PATH environment variable"'
  fi

  __chrome_driver_start__ "$driver_path" "$chrome_options"
}

function __chrome_driver_start__() {
  local driver_path="$1"
  local chrome_options="$2"
  local port=$(__get_free_port__)
  __start_driver__ "$driver_path" "$port"
  local capabilities='{ "browserName":"chrome" , "goog:chromeOptions" : '${chrome_options}' }'
  echo "$(RemoteWebDriver -u "http://localhost:${port}" -c "${capabilities}")"
}
