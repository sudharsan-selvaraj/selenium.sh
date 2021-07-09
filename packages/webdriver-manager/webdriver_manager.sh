export CACHE_DIR="$HOME/.cache/selenium-sh"
export VERSIONS_JSON="https://raw.githubusercontent.com/sudharsan-selvaraj/selenium.sh/main/packages/webdriver-manager/versions.json?token=AEZUHUJGYIWE6433QHJ3MGDA47CW4"

function main() {
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -b | --browser)
      browser="$2"
      shift
      shift
      ;;
    -v | --version)
      driver_version="$2"
      shift
      shift
      ;;
    esac
  done

  _validate_args_ "$browser"
  ## Create cache directory to store the webdriver executables
  __initialize_cache_dir__

  __webdriver_manager_setup__ "$browser" "$driver_version"
}

##############################################
#             HELPER METHODS                 #
##############################################
function _validate_args_() {
  local supported_browsers=("chrome" "firefox" "edge" "opera")
  local browser="$1"

  if [ "${browser}" == "" ] || [[ "${supported_browsers[*]}" != *${browser}* ]]; then
    echo "Unsupported browser ${browser} provided" >/dev/stderr
    exit 1
  fi
}

function __initialize_cache_dir__() {
  if [ ! -d "${CACHE_DIR}" ]; then
    mkdir -p "${CACHE_DIR}"
  fi
}

function __get_os__() {
  case "$OSTYPE" in
  linux*) echo "linux" ;;
  darwin*) echo "mac" ;;
  *) echo "unsupported" ;;
  esac
}

function __get_os_arch__() {
  local arch=$(uname -m)
  case "$arch" in
  "x86_64") echo "64" ;;
  "i386") echo "32" ;;
  esac
}

function __webdriver_manager_setup__() {
  local browser="$1"
  local driver_version="$2"

  case "$browser" in
  "chrome")
    chromedriver "$driver_version"
    ;;
  "firefox")
    firefoxdriver "$driver_version"
    ;;
  esac
}

function __get_chrome_version__() {
  local chrome_linux="google-chrome"
  local chrome_mac='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

  local os=$(__get_os__)
  if [ "$os" == "linux" ]; then
    local version=$("$chrome_linux" --version)
  else
    local version=$("$chrome_mac" --version)
  fi
  local regex='Google Chrome ([0-9]*)\.'
  [[ $version =~ $regex ]]
  local base_ver=${BASH_REMATCH[1]}
  echo "$base_ver"
}

function __get_firefox_version__() {
  local ff_linux="firefox"
  local ff_mac='/Applications/Firefox.app/Contents/MacOS/firefox'

  local os=$(__get_os__)
  if [ "$os" == "linux" ]; then
    local version=$("$ff_linux" -v)
  else
    local version=$("$ff_mac" -v)
  fi
  local regex='Mozilla Firefox ([0-9]*)\.'
  [[ $version =~ $regex ]]
  local base_ver=${BASH_REMATCH[1]}
  echo "$base_ver"
}

function __json_parser__() {
  echo $(echo $1 |
    sed -e 's/[{}]/''/g' |
    sed -e 's/", "/'\",\"'/g' |
    sed -e 's/" ,"/'\",\"'/g' |
    sed -e 's/" , "/'\",\"'/g' |
    sed -e 's/","/'\"---SEPERATOR---\"'/g' |
    awk -F=':' -v RS='---SEPERATOR---' "\$1~/\"$2\"/ {print}" |
    sed -e "s/\"$2\"://" |
    tr -d "\n\t" |
    sed -e 's/\\"/"/g' |
    sed -e 's/\\\\/\\/g' |
    sed -e 's/^[ \t]*//g' |
    sed -e 's/^"//' -e 's/"$//')
}

function __get_driver_version__() {
  local browser_name="$1"
  local versions=$(cat "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/versions.json")
  #  let versions=$(curl -s -X "GET" "$VERSIONS_JSON")
  local driver_version=$(__json_parser__ "$versions" "$browser_name")
  echo "$driver_version"
}

################################################
#               DRIVER METHODS                 #
################################################
function chromedriver() {
  local download_url="https://chromedriver.storage.googleapis.com/{driver_version}/chromedriver_$(__get_os__)64.zip"
  local chromeVersion=$(__get_chrome_version__)
  local driver_version=''
  if [ -z "$1" ]; then
    driver_version=$(__get_driver_version__ "chrome$chromeVersion")
  else
    driver_version=$1
  fi
  local download_directory="${CACHE_DIR}/chrome/${driver_version}"

  if [ -f "${download_directory}/chromedriver" ]; then
    export CHROME_DRIVER_PATH="${download_directory}/chromedriver"
  else
    mkdir -p ${download_directory}
    download_url=$(echo "$download_url" | sed 's/{driver_version}/'${driver_version}'/')
    local curl_output=$($(cd "$download_directory" && curl -sS -O "$download_url") && echo "${download_directory}")
    if [ ! -z "${curl_output}" ]; then
      $(cd ${download_directory} && unzip "chromedriver_$(__get_os__)64.zip")
      export CHROME_DRIVER_PATH="${download_directory}/chromedriver"
    fi
  fi
}

function firefoxdriver() {
  local ffVersion=$(__get_firefox_version__)
  local driver_version=''
  if [ -z "$1" ]; then
    driver_version=$(__get_driver_version__ "firefox$ffVersion")
  else
    driver_version=$1
  fi
  local os_arch=$(__get_os_arch__)
  local os_name=$("__get_os__")
  if [ "$(__get_os__)" == "mac" ]; then
    os_arch=""
    os_name="macos"
  fi
  local driver_file_name="geckodriver-v${driver_version}-${os_name}${os_arch}.tar.gz"
  local download_url="https://github.com/mozilla/geckodriver/releases/download/v${driver_version}/${driver_file_name}"

  local download_directory="${CACHE_DIR}/firefox/${driver_version}"

  if [ -f "${download_directory}/geckodriver" ]; then
    export FIREFOX_DRIVER_PATH="${download_directory}/geckodriver"
  else
    mkdir -p ${download_directory}
    local curl_output=$($(cd "$download_directory" && (curl -sSL "$download_url") > ${driver_file_name}) && echo "${download_directory}")
    if [ ! -z "${curl_output}" ]; then
      $(cd ${download_directory} && tar -xvzf "${driver_file_name}" &1>/dev/null)
      export FIREFOX_DRIVER_PATH="${download_directory}/geckodriver"
    fi
  fi
}

function webdrivermanager() {
  main "$@"
}
