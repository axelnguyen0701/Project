#!/bin/bash
#===============================================
#Set ENVIRONMENT VARIABLE
if [[ -z $EDITOR ]] 
then export $EDITOR=vim
fi
MELFORT_ROOT=/var/melfort
#===============================================
#Melfort-new
function melfort-new {
    if [[ -z $1 ]] 
        then echo "Usage: melfort-new <topic>"
    else
        file=$MELFORT_ROOT/$USER/posts/$1
            if [[ ! -f $file ]] #if file does not exist
                then
                    $EDITOR $file 
                else
                    echo "$1 already exists. Run melfort-open $1 to read."
            fi      
    fi
}

#===============================================
#Melfort-open
function melfort-open {
    if [[ $# == "0" ]] 
        then echo "Usage: melfort-open <user> <topic> where <user> is optional"
    elif [[ $# == "1" ]]; then #without <user>
        file="$MELFORT_ROOT/$USER/posts/$1"
        if [[ -f "$file" ]]; then
            $EDITOR "$file"
        else
            echo "$1 does not exists. Create it by running melfort-new $1."
        fi
    else #with user and topic
        file=$MELFORT_ROOT/$1/posts/"$2"
        if [[ -f "$file" ]]; then
            $PAGER "$file"
        else
            echo "User or topic not found. Please try again"
        fi
    fi
}

#=================================================
#Melfort search
function melfort-search {
    if [[ -z $1 ]]; then
        echo "Usage: melfort-search <tag>"
    else
        find $MELFORT_ROOT/*/posts/ -type f 2>/dev/null -print0 | xargs -0 egrep -slw "#$1" | output_search
    fi
}
#Output search
function output_search {
    awk 'BEGIN {FS="/"
                print "Search results:"}
         {printf "[%s] by [%s]\n", $6, $4}
         END {print(NR<1)?"NOTHING":"END OF SEARCH"}'
         }

#=================================================
#Melfort index
function melfort-index {
 find $MELFORT_ROOT/*/posts/ -type f 2>/dev/null| xargs egrep -wos "#\w*" | ./index.awk | ./user_tag.awk | sort
}
