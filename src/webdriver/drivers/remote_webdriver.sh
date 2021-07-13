function RemoteWebDriver() {
  local selenium_address=''
  local capabilities=''
  ##
  ## Parse arguments
  ##
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -u | --url)
      selenium_address="$2"
      shift
      shift
      ;;
    -c | --capabilities)
      if [[ "$2" == "{"* ]] && [[ "$2" == *"}" ]]; then
        capabilities="$2"
      fi
      shift
      shift
      ;;
    esac
  done

  if [ "$selenium_address" == "" ]; then
    __CHECK_AND_THROW_ERROR__ "__EXCEPTION__ $EXCEPTION EXCEPTION 'Kindly pass the selenium address using --url to start the remote webdriver session' [end] "
  elif [ "$capabilities" == "" ]; then
    __CHECK_AND_THROW_ERROR__ "__EXCEPTION__ $EXCEPTION EXCEPTION 'Kindly pass the capabilities  using --capabilities to  start the remote webdriver session' [end] "
  fi

  __remote_webdriver_start__ "$selenium_address" "$capabilities"
}

function __remote_webdriver_start__() {
  local selenium_address="$1"
  local capabilities='{ "capabilities" : { "alwaysMatch": '${2}' } }'
  echo "$(__CREATE_DRIVER__ "$selenium_address" "$capabilities")"
}
