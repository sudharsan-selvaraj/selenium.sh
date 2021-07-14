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
source ${SELENIUM_SOURCE_DIR}/utils/http_provider.sh

## webdriver
source ${SELENIUM_SOURCE_DIR}/webdriver/commands/index.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/by.sh

## drivers
source ${SELENIUM_SOURCE_DIR}/webdriver/drivers/remote_webdriver.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/drivers/chromedriver.sh
source ${SELENIUM_SOURCE_DIR}/webdriver/drivers/firefoxdriver.sh

## Packages
source ${SELENIUM_SOURCE_DIR}/packages/webdriver-manager/webdriver_manager.sh