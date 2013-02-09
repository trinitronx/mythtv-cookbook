#!/bin/bash
#
# MythShutdownCheck
#
# checks to see if any other user is
# logged in before idle shutdown
#
# returns "1" if yes, stopping shutdown
# returns "0" if ok to shutdown
#

if last | head | grep "pts/.*still logged in" | grep -qv 0.0   # check for active *remote* login?
then
   logger "Not shutting down becuase someone is logged in via SSH..."
   exit 1
elif pgrep rsync
then
    logger "Not shutting down because an rsync backup is running..."
    exit 1
elif -e /usr/local/bin/mpd_check.py && /usr/local/bin/mpd_check.py
then
    logger "Not shutting down because MPD is playing..."
    exit 1
else
   logger "Nobody is logged in via SSH, using MPD and no backup is running, so we can shut down..."
   mythshutdown --check
   exit $?
fi
