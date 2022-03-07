#!/bin/bash
#
# Downloads and updates Mewdeko.
#
########################################################################################
#### [ Variables ]


current_creds="Mewdeko/src/Mewdeko/credentials.json"
new_creds="Mewdeko_tmp/Mewdeko/src/Mewdeko/credentials.json"
current_database="Mewdeko/src/Mewdeko/bin/Release/net6.0/data/Mewdeko.db"
new_database="Mewdeko_tmp/Mewdeko/src/Mewdeko/bin/Release/net6.0/data/Mewdeko.db"
current_data="Mewdeko/src/Mewdeko/data"
new_data="Mewdeko_tmp/Mewdeko/src/Mewdeko/data"
export DOTNET_CLI_TELEMETRY_OPTOUT=1  # Used when compiling code.


#### End of [ Variables ]
########################################################################################
#### [ Main ]


read -rp "We will now download/update Mewdeko. Press [Enter] to begin."

########################################################################################
#### [[ Stop service ]]


## Stop the service if it's currently running.
if [[ $_NADEKO_SERVICE_STATUS = "active" ]]; then
    mewdeko_service_active=true
    _STOP_SERVICE "false"
fi


#### End of [[ Stop service ]]
########################################################################################
#### [[ Create Backup, Then Update ]]


## Create a temporary folder to download Mewdeko into.
mkdir Mewdeko_tmp
cd Mewdeko_tmp || {
    echo "${_RED}Failed to change working directory$_NC" >&2
    exit 1
}

echo "Downloading Mewdeko into 'Mewdeko_tmp'..."
# Download Mewdeko from a specified branch/tag.
git clone -b "$_MEWDEKO_INSTALL_VERSION" --recursive --depth 1 \
        https://github.com/Sylveon76/Mewdeko || {
    echo "${_RED}Failed to download Mewdeko$_NC" >&2
    exit 1
}

# If '/tmp/NuGetScratch' exists...
if [[ -d /tmp/NuGetScratch ]]; then
    echo "Modifying ownership of '/tmp/NuGetScratch' and '/home/$USER/.nuget'"
    # Due to permission errors cropping up every now and then, especially when the
    # installer is executed with root privilege, it's necessary to make sure that
    # '/tmp/NuGetScratch' and '/home/$USER/.nuget' are owned by the user that the
    # installer is currently being run under.
    sudo chown -R "$USER":"$USER" /tmp/NuGetScratch /home/"$USER"/.nuget || {
        echo "${_RED}Failed to to modify the ownership of '/tmp/NuGetScratch' and/or" \
            "'/home/$USER/.nuget'...$_NC" >&2
        exit 1
    }
fi

echo "Building Mewdeko..."
{
    cd Mewdeko/src/Mewdeko \
    && dotnet build -c Release \
    && cd "$_WORKING_DIR"
} || {
    echo "${_RED}Failed to build Mewdeko$_NC" >&2
    exit 1
}

## Move credentials, database, and other data to the new version of Mewdeko.
if [[ -d Mewdeko_tmp/Mewdeko && -d Mewdeko ]]; then
    echo "Copying 'credentials.json' to the new version..."
    cp -f "$current_creds" "$new_creds" &>/dev/null
    echo "Copying database to the new version..."
    cp -RT "$current_database" "$new_database" &>/dev/null

    echo "Copying other data to the new version..."

    ### On update, strings will be new version, user will have to manually re-add his
    ### strings after each update as updates may cause big number of strings to become
    ### obsolete, changed, etc. However, old user's strings will be backed up to
    ### strings_old.

    ## Backup new strings to reverse rewrite.
    rm -rf "$new_data"/strings_new &>/dev/null
    mv -fT "$new_data"/strings "$new_data"/strings_new

    ## Delete old string backups.
    rm -rf "$current_data"/strings_old &>/dev/null
    rm -rf "$current_data"/strings_new &>/dev/null

    # Backup new aliases to reverse rewrite.
    mv -f "$new_data"/aliases.yml "$new_data"/aliases_new.yml

    # Move old data folder contents (and overwrite).
    cp -RT "$current_data" "$new_data"

    # Backup old aliases.
    mv -f "$new_data"/aliases.yml "$new_data"/aliases_old.yml
    # Restore new aliases.
    mv -f "$new_data"/aliases_new.yml "$new_data"/aliases.yml

    # Backup old strings.
    mv -f "$new_data"/strings "$new_data"/strings_old
    # Restore new strings.
    mv -f "$new_data"/strings_new "$new_data"/strings

    rm -rf Mewdeko_old && mv -f Mewdeko Mewdeko_old
fi

mv Mewdeko_tmp/Mewdeko . && rmdir Mewdeko_tmp


#### End of [[ Create Backup, Then Update ]]
########################################################################################
#### [[ Clean Up and Present Results ]]


echo -e "\n${_GREEN}Finished downloading/updating Mewdeko$_NC"

if [[ $mewdeko_service_active ]]; then
    echo "${_CYAN}NOTE: '$_NADEKO_SERVICE_NAME' was stopped to update Mewdeko and" \
        "needs to be started using one of the run modes in the installer menu$_NC"
fi

read -rp "Press [Enter] to apply any existing changes to the installers"


#### End of [[ Clean Up and Present Results ]]
########################################################################################

#### End of [ Main ]
########################################################################################
