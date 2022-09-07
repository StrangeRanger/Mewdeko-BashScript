# Mewdeko-BashScript

[![Project Tracker](https://img.shields.io/badge/repo%20status-Project%20Tracker-lightgrey)](https://wiki.randomserver.xyz/en/project-tracker#mewdeko-bashscript)
[![Style Guide](https://img.shields.io/badge/code%20style-Style%20Guide-blueviolet)](https://github.com/StrangeRanger/bash-style-guide)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/7433881fd42148dda4e7862bb201d886)](https://www.codacy.com/gh/StrangeRanger/Mewdeko-BashScript/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=StrangeRanger/Mewdeko-BashScript&amp;utm_campaign=Badge_Grade)

This is the official installer for [Mewdeko](https://github.com/Pusheon/Mewdeko) on Linux distributions.

<!--For information on setting up Mewdeko using this installer, visit the repository's [wiki](https://github.com/StrangeRanger/Mewdeko-BashScript/wiki).-->

## Getting Started

### Downloading linuxAIO

The only script that needs to be manually downloaded to your system is `linuxAIO`. To do this, execute the following set of commands:

`curl -O https://raw.githubusercontent.com/StrangeRanger/Mewdeko-BashScript/main/linuxAIO && sudo chmod +x linuxAIO`

### Usage

To use the installer, execute the following command: `./linuxAIO`

If the following command was successfully executed, a menu with the following options (or something very similar) should be displayed:

``` txt
1. Download Mewdeko
2. Run Mewdeko in the background
3. Run Mewdeko in the background with auto restart
4. Stop Mewdeko
5. Display 'mewdeko.service' logs in follow mode
6. Install prerequisites
7. Exit
```

## Officially Supported Distributions

The following is a list of all the Linux distributions that the installer has been tested and are officially support on:

| Distro/OS  | Version Number      |
| ---------- | ------------------- |
| Ubuntu     | 22.04, 20.04, 18.04 |
| Linux Mint | 21, 20              |
| Debian     | 11, 10              |
