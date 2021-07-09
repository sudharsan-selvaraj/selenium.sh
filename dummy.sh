export jq="/Users/sselvaraj/Desktop/iproov authentication/jq-osx-amd64"

regex_test() {
  a="[safsdfsdf][sdfsdfsdfsdfsdf]"

echo "$a" | sed 's/.*\[\([^]]*\)\].*\[\([^]]*\)\]/\1/g'
echo "$a" | sed 's/.*\[\([^]]*\)\].*\[\([^]]*\)\]/\2/g'
}

regex_test2() {
  a="[safsdfsdf=sdfsdfsdfsdfsdf]"

echo "$a" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\1/g'
echo "$a" | sed 's/.*\[\([^]]*\)=\([^]]*\)\]/\2/g'
}

find_element_response_test() {
  echo $(echo '{ "element-sdfds-dsfsdf" : "sdfsdfsdfsdfsdf" }' | "$jq" -r 'to_entries | map("[\(.key)=\(.value)]") | .[] ')
}

find_elements_response_test() {
  echo $(echo '[{ "element-sdfds-dsfsdf" : "sdfsdfsdfsdfsdf" }, { "element-ss-aa-aaaa" : "123123123123123123" }]' | "$jq" -r '.[] | to_entries[] | "[" + (.key|tostring) + "=" + .value + "]"')
}

find_elements_response_test