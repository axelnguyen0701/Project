#!/bin/bash
#format output using awk
#UNIX to date: https://stackoverflow.com/questions/31476602/unix-time-to-date-and-replace-in-bash-using-awk
#Skip to the rest: https://www.cyberciti.biz/faq/unix-linux-bsd-appleosx-skip-fields-command/
#print the rest in awk: https://stackoverflow.com/questions/30035002/awk-how-to-print-the-rest

awk 2>/dev/null ' 
    #Check if time is valid and is after November 30th 2020
     $2 ~ /^[0-9]+$/ && $2 > 1606723200  {
        #UNIX time to date
        $2 = strftime("%d-%m-%Y %H:%M:%S",$2);
        #formatting
        printf "[%s at %s] said: ", $1, $2;
        #print rest columns
        $1=""; $2=""
        print substr($0, index($0, " ")+1, 219);}
'

if [[ $? != 0 ]]
    then 
    echo Permission denied!
    fi

