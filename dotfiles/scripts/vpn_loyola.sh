#!/bin/zsh

# based on # https://colan.consulting/blog/installing-vpn-pcf-files-ubuntu-1304
#aliases
# von
# von1m
# voff

USR="aamunoz"
HOST_RDP="10.20.44.3:3389"

status() {
    echo "TODO"
}

start() {
    arg1=$1
    sudo vpnc vpnLoyola 
    echo $arg1
    if [[ "$arg1" == "1monitor" ]]; then
        #xfreerdp +clipboard /u:$USR /size:1024x768  /sound /microphone /v:$HOST_RDP
        xfreerdp +clipboard /u:$USR /size:1920x1080 /sound /microphone /v:$HOST_RDP
        #xfreerdp +clipboard /dynamic-resolution /u:$USR  /sound /microphone /v:$HOST_RDP
    else
        xfreerdp +clipboard /multimon /u:$USR /sound /microphone /v:$HOST_RDP
    fi
}


stop() {
    echo "==== Stop"
    sudo vpnc-disconnect
}

# this function is called when Ctrl-C is sent
function trap_ctrlc ()
{
    # perform cleanup here
    echo "Ctrl-C caught...stopping VPN"
    stop()


    # exit shell script with error code 2
    # if omitted, shell script will continue execution
    exit 2
}

# initialise trap to call trap_ctrlc function
# when signal 2 (SIGINT) is received
trap "trap_ctrlc" 2

case "$1" in
    'start')
            start $2
            ;;
    'stop')
            stop
            ;;
    'restart')
            stop ; echo "Sleeping..."; sleep 1 ;
            start
            ;;
    'status')
            status
            ;;
    *)
            echo
            echo "Usage: $0 { start | stop | restart | status }"
            echo
            exit 1
            ;;
esac

exit 0
