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
    declare -a found_users

    #Format elements in the array:
    for i in ${all_messages[@]};
    do 
        i=${i%/chat/messages};
        i=${i#/var/melfort/};
        found_users+=$i;
    done;
    echo ${found_users[@]}
    #Prompt for user's message
    PS3="Choose user's messages you want to hear "
    select USER_MESSAGE in "${found_users[@]}" STOP
    do
        if [ "$USER_MESSAGE" == "" ] 
            then
                echo -e "Invalid entry.\n"
                continue
        elif [ "$USER_MESSAGE" == STOP ]
            then    
                echo "See ya!"
                break
        fi
    cat "$MELFORT_ROOT/$USER_MESSAGE/chat/messages"
    done
}
