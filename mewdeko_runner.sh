#!/bin/bash
#
# Start Mewdeko in the specified run mode, on Linux distributions.
#
# Comment key:
#   A.1. - Used in conjunction with the 'systemctl' command.
#   B.1. - Used in the text output.
#
########################################################################################
#### [ Variables ]


### Indicate which actions ('disable' or 'enable') to be performed on Mewdeko's
### service.
if [[ $_CODENAME = "MewdekoRun" ]]; then
    lower="disable"    # A.1.
    upper="Disabling"  # B.1.
else
    lower="enable"    # A.1.
    upper="Enabling"  # B.1.
fi

# PURPOSE: 'StandardOutput' and 'StandardError' no longer support 'syslog', starting in
##          version 246 of systemd.
## The contents of Mewdeko's service.
if ((_SYSTEMD_VERSION >= 246)); then
    mewdeko_service_content="[Unit]
Description=Mewdeko service
After=network.target
StartLimitIntervalSec=60
StartLimitBurst=2

[Service]
Type=simple
User=$USER
WorkingDirectory=$_WORKING_DIR
ExecStart=/bin/bash MewdekoRun.sh
Restart=on-failure
RestartSec=5
StandardOutput=journal
StandardError=journal
SyslogIdentifier=Mewdeko

[Install]
WantedBy=multi-user.target"
else
    mewdeko_service_content="[Unit]
Description=Mewdeko service
After=network.target
StartLimitIntervalSec=60
StartLimitBurst=2

[Service]
Type=simple
User=$USER
WorkingDirectory=$_WORKING_DIR
ExecStart=/bin/bash MewdekoRun.sh
Restart=on-failure
RestartSec=5
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=Mewdeko

[Install]
WantedBy=multi-user.target"
fi


#### End of [ Variables ]
########################################################################################
#### [ Main ]


# Check if the service exists.
if [[ -f $_MEWDEKO_SERVICE ]]; then echo "Updating '$_MEWDEKO_SERVICE_NAME'..."
else                               echo "Creating '$_MEWDEKO_SERVICE_NAME'..."
fi

{
    # Create/update the service.
    echo "$mewdeko_service_content" | sudo tee "$_MEWDEKO_SERVICE" &>/dev/null \
        && sudo systemctl daemon-reload
} || {
    echo "${_RED}Failed to create '$_MEWDEKO_SERVICE_NAME'" >&2
    echo "${_CYAN}This service must exist for Mewdeko to work${_NC}"
    read -rp "Press [Enter] to return to the installer menu"
    exit 1
}

## Disable/enable the service.
echo "$upper '$_MEWDEKO_SERVICE_NAME'..."
sudo systemctl "$lower" "$_MEWDEKO_SERVICE_NAME" || {
    echo "${_RED}Failed to $lower '$_MEWDEKO_SERVICE_NAME'" >&2
    echo "${_CYAN}This service must be ${lower}d in order to use this run mode${_NC}"
    read -rp "Press [Enter] to return to the installer menu"
    exit 1
}

# Check if 'MewdekoRun.sh' exists.
if [[ -f MewdekoRun.sh ]]; then
    echo "Updating 'MewdekoRun.sh'..."
## Create 'MewdekoRun.sh' if it doesn't exist.
else
    echo "Creating 'MewdekoRun.sh'..."
    touch MewdekoRun.sh
    sudo chmod +x MewdekoRun.sh
fi

## Add the code required to run Mewdeko in the background, to 'MewdekoRun.sh'.
if [[ $_CODENAME = "MewdekoRun" ]]; then
    printf '%s\n' \
        "#!/bin/bash" \
        "" \
        "_code_name_=\"MewdekoRun\"" \
        "" \
        "echo \"Running Mewdeko in the background\"" \
        "echo \"Starting Mewdeko...\"" \
        "cd $_WORKING_DIR/Mewdeko/src/Mewdeko" \
        "dotnet run -c Release || {" \
        "    echo \"An error occurred when trying to start Mewdeko\"" \
        "    echo \"Exiting...\"" \
        "    exit 1" \
        "}" \
        "echo \"Stopping Mewdeko...\"" \
        "cd $_WORKING_DIR" > MewdekoRun.sh
## Add code required to run Mewdeko in the background with auto restart, to
## 'MewdekoRun.sh'.
else
    printf '%s\n' \
        "#!/bin/bash" \
        "" \
        "_code_name_=\"MewdekoRunAR\"" \
        "" \
        "echo \"Running Mewdeko in the background with auto restart\"" \
        "echo \"Starting Mewdeko...\"" \
        "" \
        "while true; do" \
        "    if [[ -d $_WORKING_DIR/Mewdeko/src/Mewdeko ]]; then" \
        "        cd $_WORKING_DIR/Mewdeko/src/Mewdeko || {" \
        "            echo \"Failed to change working directory to '$_WORKING_DIR/Mewdeko/src/Mewdeko'\" >&2" \
        "            echo \"Ensure that the working directory inside of '/etc/systemd/system/mewdeko.service' is correct\"" \
        "            echo \"Exiting...\"" \
        "            exit 1" \
        "        }" \
        "    else" \
        "        echo \"'$_WORKING_DIR/Mewdeko/src/Mewdeko' doesn't exist\"" \
        "        exit 1" \
        "    fi" \
        "" \
        "    dotnet run -c Release || {" \
        "        echo \"An error occurred when trying to start Mewdeko\"" \
        "        echo \"Exiting...\"" \
        "        exit 1" \
        "    }" \
        "" \
        "    echo \"Waiting for 5 seconds...\"" \
        "    sleep 5" \
        "    echo \"Restarting Mewdeko...\"" \
        "done" \
        "" \
        "echo \"Stopping Mewdeko...\"" > MewdekoRun.sh
fi

## Restart the service if it is currently running.
if [[ $_MEWDEKO_SERVICE_STATUS = "active" ]]; then
    echo "Restarting '$_MEWDEKO_SERVICE_NAME'..."
    sudo systemctl restart "$_MEWDEKO_SERVICE_NAME" || {
        echo "${_RED}Failed to restart '$_MEWDEKO_SERVICE_NAME'${_NC}" >&2
        read -rp "Press [Enter] to return to the installer menu"
        exit 1
    }
## Start the service if it is NOT currently running.
else
    echo "Starting '$_MEWDEKO_SERVICE_NAME'..."
    sudo systemctl start "$_MEWDEKO_SERVICE_NAME" || {
        echo "${_RED}Failed to start '$_MEWDEKO_SERVICE_NAME'${_NC}" >&2
        read -rp "Press [Enter] to return to the installer menu"
        exit 1
    }
fi

_WATCH_SERVICE_LOGS "runner"


#### End of [ Variables ]
########################################################################################
