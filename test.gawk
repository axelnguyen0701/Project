#!/usr/bin/gawk -f

{a[1][1]=1
a[1][2]=2
for (i in a)
   for (j in a[i])
       print a[i][j]}
