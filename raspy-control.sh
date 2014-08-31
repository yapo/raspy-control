#!/bin/bash
# /etc/init.d/raspy-control.sh

### BEGIN INIT INFO
# Provides:          raspy-control
# Required-Start:    $syslog
# Required-Stop:     $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Raspy-control init script
# Description:       This service is used to manage a poweroff button
### END INIT INFO

PIDFILE=/tmp/.raspy-config.pid
PYTHON=/usr/bin/python
PYSCRIPT=/home/devel/github/raspy-control/raspy-control.py

. /lib/lsb/init-functions

start()
{
	echo "starting raspy-control" >> /tmp/.raspy-control.log
	log_action_msg "starting raspy-control service"
	sleep 1
	if [ -f $PIDFILE ]
	then
		log_failure_msg "the service seems to be running"
		exit -1
	fi
	$PYTHON $PYSCRIPT &
	sleep 1
	PID=$(ps -fA | grep raspy-control.py | grep -v grep | awk '{ print $2 }')
	echo "$PID" > $PIDFILE
	log_success_msg "service started"
}

stop()
{
	echo "stopping raspy-control" >> /tmp/.raspy-control.log
	log_action_msg "stopping raspy-control service"
	if [ -f $PIDFILE ]
	then
		PID=`cat $PIDFILE`
		rm -f $PIDFILE
		kill -15 $PID
		log_success_msg "service stopped"
	else
		log_failure_msg "the service seems to be already stopped"
	fi
}

status()
{
	PID=$(ps -fA | grep raspy-control.py | grep -v grep | awk '{ print $2 }')
	if [ -f $PIDFILE -a -n "$PID" ]
	then
		PIDF=$(cat $PIDFILE)
		if [ "$PID" = "$PIDF" ]
		then
			log_success_msg "the service is running"
		else
			log_warning_msg "the service seems to be running"
		fi
	else
		log_failure_msg "service seems to be stopped"
	fi
}

case "$1" in
	start)
		start
		;;
	poweroff)
		echo "poweroff" >> /tmp/.raspy-control.log
		poweroff
		;;
	stop)
		stop
		;;
	status)
		status
		;;
	restart)
		stop
		start
		;;
	*)
		echo $"Usage: $prog {start|stop|restart|status}"
esac

