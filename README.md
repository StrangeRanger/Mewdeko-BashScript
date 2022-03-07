# Mewdeko-BashScript

<!--[![Project Tracker](https://img.shields.io/badge/repo%20status-Project%20Tracker-lightgrey)](https://randomserver.xyz/project-tracker.html#nadekobot-bashscript)-->
[![Style Guide](https://img.shields.io/badge/code%20style-Style%20Guide-blueviolet)](https://github.com/StrangeRanger/bash-style-guide)

This is the official installer for Mewdeko on Linux distributions.

<!--For information on setting up Mewdeko using this installer, visit the repository's [wiki](https://github.com/StrangeRanger/Mewdeko-BashScript/wiki).-->

## Getting Started

### Downloading linuxAIO.sh

The only script that needs to be manually downloaded to your system is `linuxAIO.sh`. To do this, execute the following set of commands:

`curl -O https://raw.githubusercontent.com/StrangeRanger/Mewdeko-BashScript/main/linuxAIO.sh && sudo chmod +x linuxAIO.sh`

### Usage

To use the installer, execute the following command: `./linuxAIO.sh`

If the following command was successfully executed, a menu with the following options (or something very similar) should be displayed:

``` txt
1. Download Mewdeko
2. Run Mewdeko in the background
3. Run Mewdeko in the background with auto restart
4. Stop Mewdeko
5. Display 'mewdeko.service' logs in follow mode
6. Install prerequisites
7. Back up important files
8. Exit
```

## Officially Supported Distributions

The following is a list of all the Linux distributions and macOS versions that the installer has been tested and are officially support on:

| Distro/OS  | Version Number      |
| ---------- | ------------------- |
| Ubuntu     | 20.04, 18.04, 16.04 |
| Linux Mint | 20, 19, 18          |
| Debian     | 10, 9               |
