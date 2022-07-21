# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Revert some if statements to fix possible SC2015 problems.

## [v1.0.1] - 2022-07-20

### Changed

- Where possible, replaced commands with Parameter Expansion.
- Where applicable, refactored if statements to be more simplistic and functional.
- Changed how the variables used to change the color of output text, are formatted, in the hopes of increasing portability.
- Improve exit code functionality:
  - Modified traps to provide proper signal exit codes.
    - Example: 128+n where n is the signal number, such as 9 being SIGKILL.
  - Changed exit codes to non-reserved exit codes.
- NadekoBot daemon uses `journal` for `StandardOutput` and `StandardError`, instead of `syslog`, if systemd version is 246 or later.
- Checks if `/home/$USER/.nuget` exists before attempting to chown it.
- Small formatting and style changes.
- Replaced the use of master with main.

### Fixed

- Not properly retrieving `systemd` version number.
- Bad formatting of some output.
- Incorrect text printed to terminal.

## [v1.0.0] - 2022-06-20

### Added

- Support for:
  - Ubuntu 22.04
  - Debian 11
- Added shellcheck disable comments.

### Changed

- ⚠️ Installs Java 17 or Java 11 (dependent on distribution) instead of Java 13.
- Installs redis-server instead of keydb.

### Removed

- ⚠️ No longer supports Ubuntu 16.04.
- ⚠️ No longer supports Linux Mint 18, due to EOL.

## [v1.0.0-beta.1] - 2022-03-07

Initial working [beta] release.

[unreleased]: https://github.com/StrangeRanger/Mewdeko-BashScript/compare/v1.0.1...HEAD
[v1.0.1]: https://github.com/StrangeRanger/Mewdeko-BashScript/releases/tag/v1.0.1
[v1.0.0]: https://github.com/StrangeRanger/Mewdeko-BashScript/releases/tag/v1.0.0
[v1.0.0-beta.1]: https://github.com/StrangeRanger/Mewdeko-BashScript/releases/tag/v1.0.0-beta.1
