#!/usr/bin/env bash

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"

## load dependencies
source ${SOURCE_DIR}/utils/try_catch.sh
source ${SOURCE_DIR}/utils/exceptions.sh

## export executable path of jq library
export jq="/Users/sselvaraj/Desktop/iproov authentication/jq-osx-amd64"

## Check and load the respective HTTP provided between cURL and wget
function load_http_provider() {
  if [ -x "$(which wget)" ]; then
    . ${SOURCE_DIR}/http_provider/wget_provider.sh
  elif [ -x "$(which curl)" ]; then
    . ${SOURCE_DIR}/http_provider/curl_provider.sh
  else
    echo "Could not find curl or wget, please install one." >&2
  fi
}

# Source the respective HTTP provider
load_http_provider

#######################################################################################
#                               HTTP REQUEST WRAPPER                                  #
#######################################################################################

__EXECUTE_WD_COMMAND__() {
  local http_method=$1
  local url=$2
  local body=$3
  local response=''

  case "$http_method" in
  "GET")
    response=$(HTTP_GET "$url")
    ;;
  "DELETE")
    response=$(HTTP_DELETE "$url")
    ;;
  "POST")
    response="$(HTTP_POST "$url" "$body")"
    ;;
  "PATCH")
    response=$(HTTP_PATCH "$url" "$body")
    ;;
  esac

  echo "$response"
}

########################################################################################
#                                WEBDRIVER METHODS                                     #
########################################################################################

##
## Method to open a new browser
##
__CREATE_DRIVER__() {
  local BASE_URL=$1
  local CAPABILITIES=$2

  local response=$(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session" "${CAPABILITIES}")
  __CHECK_AND_THROW_ERROR__ "$response"
  echo "$response"
}

##
## Method to open the URL
##
__DRIVER_GET__() {
  local BASE_URL=$1
  local SESSION_ID=$2
  local URL=$3

  ## construct the post body
  local body="{ \"url\" : \"$URL\"}"
  echo $(__EXECUTE_WD_COMMAND__ "POST" "${BASE_URL}/session/${SESSION_ID}/url" "$body")
}

##
## Method to get the current page title
##
__DRIVER_GET_TITLE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/title")
}

##
## Method to get the current page title
##
__DRIVER_GET_PAGE_SOURCE__() {
  local BASE_URL=$1
  local SESSION_ID=$2

  local response=$(__EXECUTE_WD_COMMAND__ "GET" "${BASE_URL}/session/${SESSION_ID}/source")
}
