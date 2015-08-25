user_account CHANGELOG
======================

1.1.0
-----
- [jarosser06] - Home attr no longer has /home prepended to it

1.0.0
-----
- [jarosser06] - Renamed cookbook to user_account

0.3.1
-----
- [vblessing] - fixed test for not deleting home dir on remove action

0.3.0
-----
- [vblessing] - added home directory deletion to remove action

0.2.1
-----
- [ecwws] - update permissions to support new gid options

0.2.0
-----
- [ecwws] - added support for setting user primary group

0.1.1
-----
- [jarosser06] - removed unsused code
- [jarosser06] - cleaned up rubocop and foodcritic warnings
- [jarosser06] - using execute instead of mixlib shellout for omni group adds

0.1.0
-----
- [jarosser06] - Initial release of user
