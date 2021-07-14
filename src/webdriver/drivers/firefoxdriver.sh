function FirefoxDriver() {

  local driver_path=${FIREFOX_DRIVER_PATH}
  local firefox_option='{}'
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
    -o | --firefox_option)
      if [[ "$2" == "{"* ]] && [[ "$2" == *"}" ]]; then
        firefox_option="$2"
      fi
      shift
      shift
      ;;
    esac
  done

  if [ ! -f "$driver_path" ]; then
    __CHECK_AND_THROW_ERROR__ '__EXCEPTION__ '$EXCEPTION' FIREFOX_DRIVER_NOT_FOUND "Kindly add the path to firefox driver in FIREFOX_DRIVER_PATH environment variable"'
  fi

  __start_firefox_driver__ "$driver_path" "$firefox_option"
}

function __start_firefox_driver__() {
  local driver_path="$1"
  local firefox_option="$2"
  local port=$(__get_free_port__)
  __start_driver__ "$driver_path" "$port"
  local capabilities='{ "browserName":"firefox" , "moz:firefoxOptions" : '${firefox_option}' }'
  echo "$(RemoteWebDriver -u http://localhost:${port} -c "$capabilities")"
}
