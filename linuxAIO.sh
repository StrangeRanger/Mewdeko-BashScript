#!/bin/bash
#
# 'linuxAIO.sh' acts as the intermediary between the system Mewdeko is being hosted on
# and 'installer_prep.sh'. To prevent any conflicts with updates to the installer, this
# script has as little code as deemed necessary.
#
# README: Because this script remains on the user's system, any changes to the code that
#         are pushed to github, are never applied to the version on the user's system.
#         To get around this, the variable $_LINUXAIO_REVISION contains a revision
#         number that is updated every time any changes are made to 'linuxAIO.sh'.
#         Another variable in 'installer_prep.sh' ($current_linuxAIO_revision) gets
#         updated alongside with $_LINUXAIO_REVISION. Whenever the user executes the
#         installer, 'installer_prep.sh' will compare the two variables. If they are not
#         of equal value, the newest version of 'linuxAIO.sh' is retrieved from github.
#
########################################################################################
#### [ Variables ]

########################################################################################
#### [[ Configuration Variables ]]
#### Variables used to modify the behavior of the installer.
####
#### ~~~ THESE VARIABLES CAN BE MODIFIED BY THE END-USER ~~~
####
#### Whenever the installer retrieves the newest version of 'linuxAIO.sh', all modified
#### variables, with the exception of $installer_repo and $_FILES_TO_BACK_UP, will be
#### applied to the new version of this script.


# The repository containing all of the scripts used by the installer.
#
# The only time that this variable should be modified, is if you have created a fork of
# the repo and plan on making your own modifications to the installer.
#
# Format: installer_repo="[github username]/[repository name]"
installer_repo="StrangeRanger/Mewdeko-BashScript"

# The branch of $installer_repo that the installer will download its scripts from.
#
# Options:
#   main = Production ready code (the latest stable code)
#   dev  = Non-production ready code (has the possibility of breaking something)
#
# Default: "main"
installer_branch="main"

# The branch/tag, of Mewdeko's official repo, that the installer will download the bot
# from.
#
# Options:
#   main  = Latest version (the master/main branch)
#   x.x.x = Any other branch/tag (refer to the Mewdeko repo for available tags and
#           branches)
#
# Default: "main"
export _MEWDEKO_INSTALL_VERSION="main"


#### End of [[ Configuration Variables ]]
########################################################################################
#### [[ General Variables ]]


# Revision number of this script.
# Refer to the 'README' note at the beginning of this file for more information.
export _LINUXAIO_REVISION=2
# The URL to the raw code of a script that is specified by the other scripts.
export _RAW_URL="https://raw.githubusercontent.com/$installer_repo/$installer_branch"


#### End of [[ General Variables ]]
########################################################################################

#### End of [ Variables ]
########################################################################################
#### [ Main ]


echo "Downloading the latest installer..."
curl -O "$_RAW_URL"/installer_prep.sh
sudo chmod +x installer_prep.sh && ./installer_prep.sh
exit "$?"  # Uses the exit code passed by 'installer_prep.sh'.


#### End of [ Main ]
########################################################################################
