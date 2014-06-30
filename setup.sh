#!/bin/bash

# check if the files exists
if [ ! -f raspy-control.sh ]
then
	echo "the scripts are missing!"
	exit -1
fi

# cleanup
rm -f /etc/init.d/raspy-control.sh
rm -f /etc/rc0.d/*raspy-control
rm -f /etc/rc1.d/*raspy-control
rm -f /etc/rc2.d/*raspy-control
rm -f /etc/rc3.d/*raspy-control
rm -f /etc/rc4.d/*raspy-control
rm -f /etc/rc5.d/*raspy-control
rm -f /etc/rc6.d/*raspy-control

# install the raspy-control scripts
chmod +x raspy-control.sh
cp raspy-control.sh /etc/init.d/raspy-control.sh
update-rc.d raspy-control.sh defaults
