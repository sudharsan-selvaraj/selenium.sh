__get_free_port__() {
  for ((port_range = 2000; port_range <= 65000; port_range++)); do
    netstat -an | grep "$port_range" &>/dev/null
    if [[ $? == 1 ]]; then
      echo "$port_range"
      break
    fi
  done
}

__start_driver__() {
  local driver_path="$1"
  local port="$2"

  "$driver_path" --port="$port" &>/dev/null &

  local PID="$!"
  __wait_for_port__ "$port"
}

__wait_for_port__() {
  local available="true"
  while [ available == "true" ]; do
    netstat -an | grep $1 >/dev/null
    if [[ $? != 1 ]]; then
      break
    fi
    sleep 5
  done
}
