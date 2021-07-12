function __is_json_object__() {
  if [[ "$1" == "{"* ]] && [[ "$1" == *"}" ]]; then
    echo 1
  else
    echo 0
  fi
}