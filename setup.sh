#!/bin/bash

# check if the files exists
if [ ! -f raspy-control.sh ]
then
	echo "the scripts are missing!"
	exit -1
fi

# cleanup
rm -f /etc/init.d/raspy-control.sh
rm -f /etc/rc2.d/*raspy-control
rm -f /etc/rc3.d/*raspy-control

# install the raspy-control scripts
chmod +x raspy-control.sh
cp raspy-control.sh /etc/init.d/raspy-control.sh
cd /etc/rc2.d
ln -s ../init.d/raspy-control.sh S03raspy-control
ln -s ../init.d/raspy-control.sh K03raspy-control
cd /etc/rc3.d
ln -s ../init.d/raspy-control.sh S03raspy-control
ln -s ../init.d/raspy-control.sh K03raspy-control

