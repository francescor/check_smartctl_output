# check_smartctl_output.sh

Simple cron script that checks meaninful smartctl output, so to **detect all possible errors** on your drive, *not just* the PASSED/FAILED overall-health self-assessment test result

In case of anomalities the script prints all status bits as in https://linux.die.net/man/8/smartctl (see "Return Values")

## Installation

Download the script https://raw.githubusercontent.com/francescor/check_smartctl_output/main/check_smartctl_disk_status.sh

then

```
# adapt `DISKS_TO_CHECK='/dev/sda /dev/sdb /dev/sdc /dev/sdd'
# with the list of your disks

# make it executable
chmod +x https://raw.githubusercontent.com/francescor/check_smartctl_output/main/check_smartctl_disk_status.sh

# add a cron job, something like:

00 9  * * * /root/scripts/check_smart_disk_status.sh
```

## Requirements 

Smart capable disks, and `smartctl` Monitor Utility for SMART Disks part of Smartmontools. 

Install the Smartmontools: the packet ID will differ in the systems:

*    Debian: smartmontools
*    Fedora: kernel-utils

You need to have root rights for the script to rub
