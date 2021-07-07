HTTP_GET() {
  curl -s -X GET $1
}

HTTP_DELETE() {
  curl -s -X DELETE $1
}

HTTP_POST() {
  local URL=$1
  local BODY=$2

  curl -s -X POST \
    -H "Content-type: application/json" \
    -H "Accept: application/json" \
    -d "${BODY}" \
    ${URL}
}

HTTP_PATCH() {
  local arg from to
  while getopts 'url:body' arg; do
    case ${arg} in
    url) URL=${OPTARG} ;;
    body) BODY=${OPTARG} ;;
    *) return 1 ;; # illegal option
    esac
  done

  curl -X PATCH \
    -H "Content-type: application/json" \
    -H "Accept: application/json" \
    -d ${BODY} \
    ${URL}
}
