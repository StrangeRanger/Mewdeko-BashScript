#!/bin/bash
#
# Install all of the packages and dependencies required for Mewdeko to run on Linux
# distributions.
#
########################################################################################
#### [ Functions ]


install_prereqs() {
    ####
    # Function Info: Install required packages and dependencies needed by Mewdeko, on
	#                all compatible Linux distributions, besides Debian 9.
	#
    # Parameters:
    # 	$1 - required
    #       Distribution name.
    # 	$2 - required
    #       Distribution version.
    #   $3 - required
    #       OpenJDK version.
    ####

    echo "Installing .NET Core..."
    ## Microsoft package signing key.
    curl -O https://packages.microsoft.com/config/"$1"/"$2"/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo rm -f packages-microsoft-prod.deb

    ## Install the SDK.
    sudo apt-get update
    sudo apt-get install -y apt-transport-https \
        && sudo apt-get update \
        && sudo apt-get install -y dotnet-sdk-6.0

    ## Install Java.
    echo "Installing '$3'..."
    sudo apt-get install -y "$3"

    ## Other prerequisites.
    echo "Installing other prerequisites..."
    sudo apt-get install redis-server git ccze -y
}

unsupported() {
    ####
    # Function Info: Informs the end-user that their system is not supported by the
	#				 automatic installation of the prerequisites.
    ####

    echo "${_RED}The installer does not support the automatic installation and setup" \
        "of Mewdeko's prerequisites for your OS: $_DISTRO $_VER ${_ARCH}${_NC}"
    read -rp "Press [Enter] to return to the installer menu"
    exit 3
}


#### End of [ Functions ]
########################################################################################
#### [ Main ]


read -rp "We will now install Mewdeko's prerequisites. Press [Enter] to continue."

if [[ $_DISTRO = "ubuntu" ]]; then
    case "$_VER" in
        18.04|20.04|22.04) install_prereqs "ubuntu" "$_VER" "openjdk-17-jdk" ;;
        *)                 unsupported ;;
    esac
elif [[ $_DISTRO = "debian" ]]; then
    case "$_SVER" in
        11) install_prereqs "debian" "11" "openjdk-17-jdk" ;;
        10) install_prereqs "debian" "10" "openjdk-11-jdk" ;;
        9)
            echo "Installing .NET Core..."
            ## Microsoft package signing key.
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg \
                --dearmor > microsoft.asc.gpg
            sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
            curl -sO https://packages.microsoft.com/config/debian/9/prod.list
            sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
            sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
            sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list

            ## Install the SDK.
            sudo apt-get update
            sudo apt-get install -y apt-transport-https \
                && sudo apt-get update \
                && sudo apt-get install -y dotnet-sdk-6.0

            ## Install Java.
            echo "Installing 'openjdk-11-jdk'..."
            sudo apt install openjdk-11-jdk -y

            ## Other prerequisites.
            echo "Installing other prerequisites..."
            sudo apt-get install redis-server git ccze -y
            ;;
        *)  unsupported ;;
    esac
elif [[ $_DISTRO = "linuxmint" ]]; then
    case "$_SVER" in
        19|20) install_prereqs "ubuntu" "$_VER" "openjdk-17-jdk" ;;
        *)     unsupported ;;
    esac
fi

echo -e "\n${_GREEN}Finished installing prerequisites${_NC}"
read -rp "Press [Enter] to return to the installer menu"


#### End of [ Main ]
########################################################################################
