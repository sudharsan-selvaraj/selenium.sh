#!/usr/bin/env bash

VERSION="v1.0.0-SNAPSHOT"
filename_name="selenium-sh-${VERSION}.tar.gz"
tarball_url="https://github.com/sudharsan-selvaraj/selenium.sh/releases/download/${VERSION}/${filename_name}"
selenium_directory="$(pwd)/selenium"

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

function download_dependencies() {
  echo "Downloading dependencies.."

  local bin_dir="$1/bin"
  mkdir -p "$bin_dir"
  local jq_file_name=''
  if [ "$(__get_os__)" == "linux" ]; then
    jq_file_name+="jq-linux$(__get_os_arch__)"
  else
    jq_file_name+="jq-osx-amd64"
  fi
  local jq_url="https://github.com/stedolan/jq/releases/download/jq-1.6/${jq_file_name}"
  (cd "$bin_dir" && (curl -sSL "$jq_url" >$jq_file_name) && mv "$jq_file_name" "jq" && chmod +x "jq")
}

function main() {
  echo "Downloading selenium.sh into ${selenium_directory}"
  tmp_dir=$(mktemp -d 2>/dev/null || mktemp -d -t 'tmpdir')
  (cd "$tmp_dir" && (curl -sSL "$tarball_url" >"${filename_name}") && tar -xvzf "${filename_name}" &>/dev/null && rm "${filename_name}")
  download_dependencies "$tmp_dir"
  cp -a "${tmp_dir}" "${selenium_directory}"

  rm -rf "$tmp_dir"
  echo "Thanks for downloading selenium.sh. you can start using by importing /selenium/selenium.sh into the shell script"
}

main
