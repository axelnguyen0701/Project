#!bin/bash

#=============================================================
#CONSTANTS
MELFORT_ROOT=/var/melfort

#==============================================================
#MELFORT SAY
#Get date in UNIX: https://stackoverflow.com/questions/1092631/get-current-time-in-seconds-since-the-epoch-on-linux-bash

function melfort-say {
   echo $(date "+%s") $* >> $MELFORT_ROOT/$USER/chat/messages 
   }

#=============================================================
#MELFORT HEAR
function melfort-hear {
    #Put all path to users' messages to  an array all_messages
    all_messages=($(find $MELFORT_ROOT -name messages 2>/dev/null | xargs echo))
    declare -A users_messages

    #Format elements in the array:
    for i in ${all_messages[@]};
    do
        path=$i;
        name=${i%/chat/messages};
        name=${name#/var/melfort/};
        users_messages[$name]="$path";
    done;   

    #Prompt for user's message
    PS3="Choose user's messages you want to hear "
    select USER_NAME in "${!users_messages[@]}" STOP
    do
        if [ "$USER_NAME" == "" ] 
            then
                echo -e "Invalid entry.\n"
                continue
        elif [ "$USER_NAME" == STOP ]
            then    
                echo "See ya!"
                break
        fi
       ./output.sh $USER_NAME ${users_messages[$USER_NAME]}
    done
}
