#!/bin/sh

#!/bin/sh
#
# set ACPI Wakeup time
# usage: setwakeup.sh seconds
#    seconds - number of seconds from epoch to UTC time (time_t time format)
#
# set UTCBIOS to true if bios is using UTC time
# set UTCBIOS to false if bios is using local time

LOG=/var/log/mythtv/mythbackend.log
UTCBIOS=true

logger -s "Running $0 to set the wakeup time to $1" >> $LOG

if $UTCBIOS
then
    #utc bios - use supplied seconds
    SECS=$1
else
    #non utc bios - convert supplied seconds to seconds from
    #epoch to local time
    SECS=`date -u --date "\`date --date @$1 +%F" "%T\`" +%s`
fi

echo 0 > /sys/class/rtc/rtc0/wakealarm       # clear alarm
echo $SECS > /sys/class/rtc/rtc0/wakealarm   # write the waketime

logger -s "RTC Alarm now has the time: `cat /proc/driver/rtc`" >> $LOG
