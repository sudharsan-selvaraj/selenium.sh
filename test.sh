#!/usr/bin/env bash

. webdriver/commands.sh

__CREATE_DRIVER__ "http://localhost:4445/wd/hub" '{ "capabilities": { "alwaysMatch" : { "browserName": "chrsome" } } }'

try
(
  begin
  try
  (
    begin
    driver=$(__CREATE_DRIVER__ "http://localhost:4445/wd/hub" '{ "capabilities": { "alwaysMatch" : { "browserName": "chrsome" } } }')
    $driver.click
  )
  catch || {
    echo "$exception_code"
    case $exception_code in
    $SESSION_NOT_CREATED_EXCEPTION)
      echo "Unable to create session inner ${exit_code}"
      ;;
    esac
  }

  driver=$(__CREATE_DRIVER__ "http://localhost:4445/wd/hub" '{ "capabilities": { "alwaysMatch" : { "browserName": "chrsome" } } }')
  $driver.click
)
catch || {
  echo "$exception_code"
  case $exception_code in
  $SESSION_NOT_CREATED_EXCEPTION)
    echo "Unable to create session ${exit_code}"
    ;;
  esac
}
