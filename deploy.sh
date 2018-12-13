#!/bin/bash

#User settings
source ./deploy.conf

#System settings
pjdir=$prefix/$renewrepo
lampdir=$pjdir/$lamprepo
timestamp=`date +%F`
filelist=`ls | grep $mask`

function backup {
    if ! [ -d $backup ]; then
	mkdir $backup
    else
	if ! [ -d $backup/$renewrepo ]; then
	    mkdir $backup/$renewrepo
	else
	    tar -czvf "$backup/$renewrepo/$renewrepo$timestamp.tar.gz" $pjdir/$renewrepo/*  
	fi
    fi  
}

function checkpj {
    if ! [ -d $pjdir ]; then
	mkdir $pjdir
    else
	read -p "Project not empty, overwrite? Y/any " -n 1 -r
	echo    
	if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
	    exit 1
	fi
	    echo "Update mode"
    fi
}

function checklamp {
cd $pjdir
    if [ -d $lampdir ]; then
	read -p "LAMP already installed, overwrite? Y/any" -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	    rm -rfv $lampdir
	    git clone https://github.com/$lampuser/$lamprepo
	else
	    echo "LAMP not updated"
	fi
    else
	git clone https://github.com/$lampuser/$lamprepo
    fi
}

function renew {
cd $pjdir
backup
if [ -d $renewrepo ]; then
    rm -rfv $renewrepo
fi
git clone https://github.com/$renewuser/$renewrepo
cp -rf $renewrepo/$filelist $lampdir/www/
echo "DROP DATABASE IF EXISTS $renewrepo" | mysql 
musql $renewrepo < $renerepo/dump.sql
}

function installreq {
    chmod +x $lampdir/install_requiments.sh
    sh $lampdir/install_requiments.sh
}

function dockerbuild {
    cd $lampdir
    /usr/bin/docker-compose up --build
}
installreq
checkpj
checklamp
dockerbuild
renew
