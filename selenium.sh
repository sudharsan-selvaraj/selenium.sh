export SELENIUM_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

## export executable path of jq library
export jq="/Users/sselvaraj/Desktop/iproov authentication/jq-osx-amd64"

##################################################################
#                       load dependencies                        #
##################################################################

## utils
source ${SELENIUM_SOURCE_DIR}/utils/try_catch.sh
source ${SELENIUM_SOURCE_DIR}/utils/exceptions.sh

## webdriver
source ${SELENIUM_SOURCE_DIR}/webdriver/commands/index.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/by.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/webdriver.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/element.sh


## Check and load the respective HTTP provided between cURL and wget
function load_http_provider() {
  if [ -x "$(which wget)" ]; then
    . ${SELENIUM_SOURCE_DIR}/http_provider/wget_provider.sh
  elif [ -x "$(which curl)" ]; then
    . ${SELENIUM_SOURCE_DIR}/http_provider/curl_provider.sh
  else
    echo "Could not find curl or wget, please install one." >&2
  fi
}

# Source the respective HTTP provider
load_http_provider
