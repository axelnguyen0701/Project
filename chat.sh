#!bin/bash
MELFORT_ROOT=/var/melfort
function melfort-say {
   echo $(date "+%s") $* > $MELFORT_ROOT/$USER/chat/messages 
   }
