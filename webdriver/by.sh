#!/usr/bin/env bash

ById() {
  ByCssSelector "#$1"
}

ByName() {
  ByCssSelector '[name=\"'$1'\"]'
}

ByXpath() {
  GetBy "xpath" $1
}

ByCssSelector() {
  GetBy "css selector" $1
}

ByLinkText() {
  GetBy "link text" $1
}

ByPartialLinkText() {
  GetBy "partial link text" $1
}

ByTagName() {
  GetBy "tag name" $1
}

GetBy() {
  local payload="{ \"using\" : \"$1\", \"value\" : \"$2\"}"
  echo "$payload"
}
