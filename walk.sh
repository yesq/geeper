#!/bin/bash  
   
function walk()  
{  
    for file in `ls $1`  
    do  
        local path=$1"/"$file  
        if [ -d $path ]  
        then  
            echo "DIR $path"  
            if [ [ -f $path/hooks/post-update.sample ] ]
            then
                cp /usr/share/git-core/templates/hooks/post-update $path/hooks/post-update
            fi
            walk $path  
        else  
            echo "FILE $path"  
        fi  
    done  
}  
   
if [ $# -ne 1 ]  
then  
    echo "USAGE: $0 TOP_DIR"  
else  
    walk $1  
fi