#!/usr/bin/env bash

by_id() {
  by_css_selector "#$1"
}

by_name() {
  by_css_selector '[name=\"'$1'\"]'
}

by_xpath() {
  get_by "xpath" $1
}

by_css_selector() {
  get_by "css selector" $1
}

by_link_text() {
  get_by "link text" $1
}

by_partial_link_text() {
  get_by "partial link text" $1
}

by_tag_name() {
  get_by "tag name" $1
}

get_by() {
  local payload="{ \"using\" : \"$1\", \"value\" : \"$2\"}"
  echo "$payload"
}
