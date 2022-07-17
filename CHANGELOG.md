# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Replaced commands with Parameter Expansion, where possible.
- Changed how the variables used to change the color of output text, are formatted, in the hopes of increasing portability.
- Refactored if statements to be more simplistic, where applicable.
- Improve exit code functionality:
  - Modified traps to provide proper signal exit codes.
    - Example: 128+n where n is the signal number, such as 9 being SIGKILL.
  - Changed exit codes to non-reserved exit codes.
- Mewdeko daemon uses `journal` for `StandardOutput` and `StandardError`, instead of `syslog`, if systemd version is 246 and above.
- Updated function info formatting.
- Small style changes.
<!-- - Downloading 'mewdeko_main_installer' text gets replaced with with the Welcome to the installer text.-->

### Fixed

- Not properly retrieving `systemd` version number.
- Small fix for bad formatting of the output of cleaning and exit text.
- Fix incorrect text printed to terminal.

## [v1.0.0] - 2022-06-20

### Added

- Added support for Ubuntu 22.04.
- Added support for Debian 11.
- Added shellcheck disable comments.

### Changed

- ⚠️ Now installs Java 17 or Java 11 (dependent on distribution) instead of Java 13.
- ⚠️ Removed support for Ubuntu 16.04.
- ⚠️ Removed support of Linux Mint 18 due to EOL.
- Installs redis-server instead of keydb.

## [v1.0.0-beta.1] - 2022-03-07

Initial working [beta] release.

[unreleased]: https://github.com/StrangeRanger/Mewdeko-BashScript/compare/v1.0.0...HEAD
[v1.0.0]: https://github.com/StrangeRanger/Mewdeko-BashScript/releases/tag/v1.0.0
[v1.0.0-beta.1]: https://github.com/StrangeRanger/Mewdeko-BashScript/releases/tag/v1.0.0-beta.1
