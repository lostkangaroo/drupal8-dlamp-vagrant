#!/usr/bin/env bats

load test_helper

@test "PHP is executable" {
  run php -v
  assert_success
}

@test "drush is executable" {
  run /usr/bin/drush -h
  assert_success
}
