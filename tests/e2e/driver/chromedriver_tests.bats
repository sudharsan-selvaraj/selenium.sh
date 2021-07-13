load 'bootstrap'

@test "first test" {

  driver="$(ChromeDriver)"
  [ "Google" == "Google" ]

}