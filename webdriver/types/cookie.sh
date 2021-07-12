__COOKIE__() {
  local file_path="$1"
  local index="$2"
  local method="$3"

  local json=$(echo "$(cat $file_path)" | "$jq" -r '.['$index']')
  echo "$json" > response.txt
  case "$method" in
  .name | .value | .path | .domain | .secure | .httpOnly | .expiry)
    echo $(echo "$json" | "$jq" -r ''$method'')
    ;;
  *)
    echo "null"
    ;;
  esac
}
