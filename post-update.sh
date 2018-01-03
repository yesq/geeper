#!/bin/sh

# some var for remote repo's path
fullPath=$(pwd)
prePath="/data/git/gogs-repositories"
path=${fullPath:${#prePath}}
if [ ${#REMOTEPATH} = 0 ]
then
    remotePrePath="/tmp/repos"
else
    remotePrePath=$REMOTEPATH
fi

# init remote repo
if [ ! -f "init" ]
then
    echo "init" >> log && \
    ssh gitsshd "mkdir -p $remotePrePath$path" && \
    scp -r . gitsshd:$remotePrePath$path && \
    ssh gitsshd "mv $remotePrePath$path/hooks/update $remotePrePath$path/hooks/update.sample" && \
    ssh gitsshd "mv $remotePrePath$path/hooks/post-update $remotePrePath$path/hooks/post-update.sample" && \
    git remote add origin gitsshd:$remotePrePath$path && \
    touch init && \
    echo "init ok" >> log
fi

# push update to remote
if [ "${1:0:11}" = "refs/heads/" ] && [ -f "init" ];then
    git push origin ${1:11} && \
    echo "push ok" >> log
fi