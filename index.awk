#!/usr/bin/gawk -f
BEGIN {FS="#";
       path = "~nguyent283/cmpt220/project/path.awk"}
{ print $1 |& path 
  close(path, "to")

  path |& getline $1

  printf "%s", $1

  $1=""

  print

  close(path, "from")
}

