#!/bin/bash

# Cron script that checks smartctl output for a list of disks
# https://github.com/francescor/check_smartctl_output
# We check smartctl exit code, and also some "useful" smartctl output as in https://askubuntu.com/questions/20393/how-do-i-interpret-hdd-s-m-a-r-t-results
# iso: we just read value that makes sense: all values shoud return zero

# list of disk to check
DISKS_TO_CHECK='/dev/sda /dev/sdb /dev/sdc /dev/sdd'

# no need to do anything below
SMART_LINES_TO_CHECK="Offline_Uncorrectable|Reallocated_Sector_Ct|Current_Pending_Sector"
SMARTCTL=`which smartctl`
EGREP=`which egrep`
UNIQ=`which uniq`
AWK=`which awk`

exit_code=0
for disk in $DISKS_TO_CHECK; do
  output=`$SMARTCTL -a $disk`
  smartctl_exit_code=$?
  if ! [ $smartctl_exit_code -eq 0 ] ; then
	echo "Disk: $disk"
        echo "Error: something went wrong while executing smartctl on disk: $disk"
	echo "since the exit code is not 0; it is $smartctl_exit_code"  
        # check Bit, as in https://linux.die.net/man/8/smartctl
	echo "These are all status bits:"
        status=$smartctl_exit_code
        for ((i=0; i<8; i++)); do
          echo "Bit $i: $((status & 2**i && 1))"
        done
	echo "See 'man smartctl' and search for 'Return Values'"
	echo "Execute it yourself with:"
        echo "$SMARTCTL -a $disk"
	echo
	exit_code=$smartctl_exit_code
  else
    result=`echo "$output" |  $EGREP \"$SMART_LINES_TO_CHECK\" | $AWK '{print $10}' | $UNIQ`
    if ! [ "$result" -eq "0" ] ; then
      echo "Disk: $disk"
      echo "Warning: smartctl returned some non zero values on meaninful output for disk: $disk"
      echo "Check it youself with:"
      echo "smartctl -a $disk |egrep \"$SMART_LINES_TO_CHECK\""
      echo
    fi
  fi
done
exit $exit_code
