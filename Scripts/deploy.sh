#!/bin/bash


# Constants variables
REPO=${PWD};

if [ "${PWD##*/}" != "scripts" ]
then
    cd "scripts";
else
    REPO='${PWD}/..'
fi

SCRIPTS=${PWD};


### Local variables
help=false
podversion=''
gitcomment=''
gitbranch=''
extbkp=''


# Source utilities
source "${SCRIPTS}/helpers.sh"


### Parse arguments
while getopts ":v:c:b:h" opt; do
    case "${opt}" in
        v)  podversion=$OPTARG;;
        c)  gitcomment=$OPTARG;;
        b)  gitbranch=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    ehelp "./Scripts/deploy.sh -v \"1.0.0\" -c \"Release 1.0.0\" -b master"
    exit 0
fi

if [ -z "${podversion}" ]
then
    eerror "Not POD version specified use \"-v\" argument"
    exit 1
fi

if [ -z "${gitbranch}" ]
then
    gitbranch='master'
    ewarn "Not GIT branch specified, the default branch is $gitbranch. For set a branch use \"-b\" argument"
fi


### Source function
edebug "Deploying POD v$podversion"

cd "$REPO"

#################################
###### Push and tagging in GIT
#################################
if ! [ -z "${gitcomment}" ]
then
    edebug "Checkout branch $gitbranch"
    if ! [ -z "$(git branch -a | egrep $gitbranch)" ]
    then
        git checkout $gitbranch
    else
        edebug "Branch $gitbranch not exists in this repository. Creating branch..."
        git checkout -b $gitbranch

        created="$?"
        if [ "$created" != 0 ]
        then
            eerror "Branch $gitbranch not possible create"
            exit $created
        fi
        edebug "Branch $gitbranch created OK"
    fi

    edebug "Add, commit and push repository"
    git add --all
    git commit -m "$gitcomment"
    git push origin $gitbranch

    edebug "Tagging version $podversion"
    git tag "$podversion" -m "$gitcomment" -f
    git push origin --tags -f
fi

pod trunk push $(getpodfile)

edebug "Deploy OK"
