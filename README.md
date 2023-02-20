# check_smartctl_output

Simple cron script that checks meaninful smartctl output

## Installation

download the script https://raw.githubusercontent.com/francescor/check_smartctl_output/main/check_smartctl_disk_status.sh

# adapt `DISKS_TO_CHECK='/dev/sda /dev/sdb /dev/sdc /dev/sdd'
# with the list of your disks

# make it executable
chmod +x https://raw.githubusercontent.com/francescor/check_smartctl_output/main/check_smartctl_disk_status.sh

# add a cron job, something like:

00 9  * * * /root/scripts/check_smart_disk_status.sh
```

## Requirements 

Smart capable disks, and `smartctl` Monitor Utility for SMART Disks
