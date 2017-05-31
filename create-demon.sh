#!/bin/bash
#based off: https://gist.github.com/naholyr/4275302
set -e
template=$'#!/bin/sh\n### BEGIN INIT INFO\n# Provides:          <NAME>\n# Required-Start:    $local_fs $network $named $time $syslog\n# Required-Stop:     $local_fs $network $named $time $syslog\n# Default-Start:     2 3 4 5\n# Default-Stop:      0 1 6\n# Description:       <DESCRIPTION>\n### END INIT INFO\n\nSCRIPT=<COMMAND>\nRUNAS=<USERNAME>\n\nPIDFILE=/var/run/<NAME>.pid\nLOGFILE=/var/log/<NAME>.log\n\nstart() {\n  if [ -f /var/run/$PIDNAME ] && kill -0 $(cat /var/run/$PIDNAME); then\n    echo \'Service already running\' >&2\n    return 1\n  fi\n  echo \'Starting service…\' >&2\n  local CMD="$SCRIPT &> \\"$LOGFILE\\" & echo \\$!"\n  su -c "$CMD" $RUNAS > "$PIDFILE"\n  echo \'Service started\' >&2\n}\n\nstop() {\n  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then\n    echo \'Service not running\' >&2\n    return 1\n  fi\n  echo \'Stopping service…\' >&2\n  pkill -P $(cat "$PIDFILE") && rm -f "$PIDFILE"\n  echo \'Service stopped\' >&2\n}\n\nuninstall() {\n  echo -n "Are you really sure you want to uninstall this service? That cannot be undone. [yes|No] "\n  local SURE\n  read SURE\n  if [ "$SURE" = "yes" ]; then\n    stop\n    rm -f "$PIDFILE"\n    echo "Notice: log file is not be removed: \'$LOGFILE\'" >&2\n    update-rc.d -f <NAME> remove\n    rm -fv "$0"\n  fi\n}\n\ncase "$1" in\n  start)\n    start\n    ;;\n  stop)\n    stop\n    ;;\n  uninstall)\n    uninstall\n    ;;\n  restart)\n    stop\n    start\n    ;;\n  *)\n    echo "Usage: $0 {start|stop|restart|uninstall}"\nesac'


#verify
if [ -z ${name+x} ] || [ -z ${username+x} ] || [ -z ${command+x} ]; then
	echo "Error: All parameters need to be set"
	exit 1
fi

if [ -f "/etc/init.d/$name" ]; then
	echo "Error: Service '$name' already exists"
	exit 1
fi

if ! id -u "$username" &> /dev/null; then
	echo "Error: User '$username' not found"
	exit 1
fi

#fill in template
template="${template//<NAME>/$name}"
template="${template//<USERNAME>/$username}"
template="${template//<DESCRIPTION>/${description:-foo}}"
template="${template//<COMMAND>/$(printf %q "$command")}"

#install
echo -e "$template" > "/etc/init.d/$name"
chmod +x "/etc/init.d/$name"
touch "/var/log/$name.log"
chown "$username" "/var/log/$name.log"
update-rc.d "$name" defaults
service "$name" start
