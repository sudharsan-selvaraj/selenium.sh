export SELENIUM_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../src" &>/dev/null && pwd)"
source "${SELENIUM_SOURCE_DIR}/selenium.sh"
source "${SELENIUM_SOURCE_DIR}/packages/webdriver-manager/webdriver_manager.sh"

webdrivermanager --browser "chrome"
webdrivermanager --browser "firefox"

