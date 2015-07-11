#!/usr/bin/env bats

load test_helper

@test "PHP is executable" {
  run php -v
  assert_success
}

@test "PHP config does not contain errors" {
  # Redirect stdout to /dev/null so we can check stderr
  run bash -c "php -v > /dev/null"
  assert_output ""
}
