__get_free_port__() {
  for ((port_range = 4444; port_range <= 9000; port_range++)); do
    if [[ "$(nc -vz 127.0.0.1 "$port_range" 2>&1)" == *"failed"* ]]; then
      echo $port_range
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

  while [[ "$(nc -vz 127.0.0.1 "$1" 2>&1)" == *"failed"* ]]; do
      echo "$(nc -vz 127.0.0.1 "$1" 2>&1)"
      sleep 5
  done
}
