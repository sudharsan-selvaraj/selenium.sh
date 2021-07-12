export SELENIUM_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

## export executable path of jq library
export jq="/Users/sselvaraj/Desktop/iproov authentication/jq-osx-amd64"

##################################################################
#                       load dependencies                        #
##################################################################
## data types
source ${SELENIUM_SOURCE_DIR}/webdriver/types/list.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/types/webdriver.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/types/element.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/types/cookie.sh

## utils
source ${SELENIUM_SOURCE_DIR}/utils/try_catch.sh
source ${SELENIUM_SOURCE_DIR}/utils/exceptions.sh
source ${SELENIUM_SOURCE_DIR}/utils/driver_utils.sh
source ${SELENIUM_SOURCE_DIR}/utils/bash_utils.sh

## webdriver
source ${SELENIUM_SOURCE_DIR}/webdriver/commands/index.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/by.sh

## drivers
source ${SELENIUM_SOURCE_DIR}/webdriver/drivers/remote_webdriver.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/drivers/chromedriver.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/drivers/firefoxdriver.sh

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
