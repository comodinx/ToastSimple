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
podname=''
podversion=''
extbkp=''


# Source utilities
source "${SCRIPTS}/helpers.sh"


### Parse arguments
while getopts ":n:v:h" opt; do
    case "${opt}" in
        n)  podname=$OPTARG;;
        v)  podversion=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    ehelp "./Scripts/install.sh -n \"MyPodName\" -v \"1.0.0\""
    exit 0
fi

if [ -z "${podname}" ]
then
    ewarn "Please set a POD name with \"-n\" argument"
    exit 1
fi

if [ -z "${podversion}" ]
then
    podversion='1.0.0'
    ewarn "Not POD version specified, the default version is $podversion. For set version use \"-v\" argument"
fi

cd $REPO;
if [ -f "$REPO/$podname.podspec" ]
then
    ewarn "Pod $podname is already install"
    exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]
then
    extbkp='.bkp'
fi


### Source function
edebug "Installing $podname v$podversion"

##############
###### Podspec
##############
filePodspec="$podname.podspec"
edebug "Prepare podspec file $filePodspec"

mv BasePod.podspec "$filePodspec"
sudo sed -i $extbkp "s/BasePodVersion/$podversion/g" "$REPO/$filePodspec"
sudo sed -i $extbkp "s/BasePod/$podname/g" "$REPO/$filePodspec"

##############
###### Sources
##############
fileSource="Sources/$podname.swift"
edebug "Prepare source file $fileSource"

mv Sources/BasePod.swift "$fileSource"
sudo sed -i $extbkp "s/BasePod/$podname/g" "$REPO/$fileSource"

################
###### README.md
################
edebug "Prepare README.md file"

mv README.md "INSTRUCTIONS.md"
mv BasePodREADME.md "README.md"
sudo sed -i $extbkp "s/BasePod/$podname/g" "$REPO/README.md"

###########
###### Demo
###########
edebug "Prepare demo"

sudo sed -i $extbkp "s/BasePod/$podname/g" "$REPO/Demo/Podfile"
sudo sed -i $extbkp "s/BasePod/$podname/g" "$REPO/Demo/Demo/ViewController.swift"

################################
###### Install demo dependencies
################################
edebug "Install demo dependencies"

cd "$REPO/Demo"
pod install

####################
###### Clean backups
####################
edebug "Clean directory"

cd "$REPO"

rm -rf .git/

if [ -f "$filePodspec$extbkp" ]
then 
    rm -f "$filePodspec$extbkp"
fi

if [ -f "$fileSource$extbkp" ]
then 
    rm -f "$fileSource$extbkp"
fi

if [ -f "README.md$extbkp" ]
then 
    rm -f "README.md$extbkp"
fi

if [ -f "Demo/Podfile$extbkp" ]
then 
    rm -f "Demo/Podfile$extbkp"
fi

if [ -f "Demo/Demo/ViewController.swift$extbkp" ]
then
    rm -f "Demo/Demo/ViewController.swift$extbkp"
fi

edebug "Install OK"
