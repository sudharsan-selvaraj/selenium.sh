HTTP_GET() {
  curl -sS -X GET $1
}

HTTP_DELETE() {
  curl -sS -X DELETE $1
}

HTTP_POST() {
  local URL=$1
  local BODY=$2

  curl -sS -X POST \
    -H "Content-type: application/json" \
    -H "Accept: application/json" \
    -d "${BODY}" \
    ${URL}
}

HTTP_PATCH() {
  local URL=$1
  local BODY=$2

  curl -sS -X PATCH \
    -H "Content-type: application/json" \
    -H "Accept: application/json" \
    -d ${BODY} \
    ${URL}
}
