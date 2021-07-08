. selenium.sh

driver=$(__CREATE_DRIVER__ "http://localhost:4444/wd/hub" '{ "capabilities": { "alwaysMatch" : { "browserName": "chrome" } } }')

$driver.get "https://www.google.com"
echo $($driver.getTitle)
$driver.refresh
$driver.get "https://www.facebook.com"
echo $($driver.getTitle)
$driver.back
echo $($driver.getTitle)
$driver.forward
$driver.quit

#res=$(cat out.txt )
#echo $( echo $res | "$jq" '.value.message')
