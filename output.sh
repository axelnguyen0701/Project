#!/bin/bash
#format output using awk
#UNIX to date: https://stackoverflow.com/questions/31476602/unix-time-to-date-and-replace-in-bash-using-awk
#Skip to the rest: https://www.cyberciti.biz/faq/unix-linux-bsd-appleosx-skip-fields-command/
#print the rest in awk: https://stackoverflow.com/questions/30035002/awk-how-to-print-the-rest
awk -v user=$1 ' {
    #UNIX time to date
    $1 = strftime("%d-%m-%Y %H:%M:%S",$1);
    #formatting
    printf "%s at %s said: ", user, $1;
    #print rest columns
    $1=""
    print substr($0, index($0, " ")+1, 219);
}
' $2
