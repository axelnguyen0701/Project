#!/usr/bin/gawk -f
#check if the post of that user already exist. If not then add it to users_posts collection 
{if (tags[$1][$2][$3]=="")
     tags[$1][$2][$3] = $3
 if (tags_data[$3]=="")
     tags_data[$3] = $3
}
END {
    for (tag in tags_data) {
        printf "\n\033[1;31m[%-15s]:\033[0m", tag;
        for (u in tags){
            for (p in tags[u]){
                if (tags[u][p][tag])
                    printf "\033[1;32m%s\033[0m by %s. ", p, u; 
            }
        }
    }
    print "" 
}

