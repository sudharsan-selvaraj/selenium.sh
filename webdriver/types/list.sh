__LIST_TYPE__() {

  local actual_type="$1"
  local args=("$@")
  local end_index=""
  local start_index=""

  for ((n = 0; n <= $#; n++)); do
    if [[ ${args[n]} == "[start]"* ]]; then
      start_index=$(( n + 1 ))
    elif [[ ${args[n]} == "[end]"* ]]; then
      end_index=$(( n -1 ))
    fi
  done

  local args_start_index=$(( end_index + 2 ));
  local method="${args[args_start_index]}"
  local total_size=$(((end_index - start_index) + 1))

  case "$method" in
  ".get")
    local index=${args[$(echo $(( args_start_index + 1)))]}
    if [ "${index}" -ge "${total_size}" ]; then
      __CHECK_AND_THROW_ERROR__ "__EXCEPTION__ $EXCEPTION INDEX_OUT_OF_BOUND 'Index: ${index}, Size: ${total_size}' [end] "
    fi
    local entity=${args[$(echo $((start_index + index)))]}
    __PROCESS_RESPONSE__ "$actual_type ${@:2:$(( start_index - 2 ))} ${entity} "
    ;;
  ".size")
    echo "$total_size"
    ;;
  esac
}
