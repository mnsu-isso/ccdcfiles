#!/bin/bash





FILEPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd )
SCRIPTPATH=${FILEPATH}/scripts

mkdir -p $SCRIPTPATH
cd $SCRIPTPATH

wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/010-block-all-incoming-traffic.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/015-lock-user-passwords.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/016-lock-mysql-users.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/017-fix-configs.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/020-allow-whitelisted-ports.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/030-update-sources-list.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/040-purge-software.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/050-update-software.sh
wget --no-check-certificate https://github.com/Ohelig/ccdcfiles/raw/master/ubuntu/scripts/070-enable-traffic.sh

cd $FILEPATH

chmod u+x ${SCRIPTPATH}/*

echo Running scripts in ${SCRIPTPATH}...
for SCRIPT in ${SCRIPTPATH}/*
do
	if [ -f $SCRIPT -a -x $SCRIPT ]
	then
		echo Running: $SCRIPT
		$SCRIPT
	fi
done
echo 'finished\n'

