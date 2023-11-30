#!/bin/bash

# A script I used on my home Linux box to evaluate USB Device speed
# matt@firestorm:~$ uname -ar
# Linux firestorm 6.2.0-37-generic #38~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov  2 18:01:13 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
# matt@firestorm:~$ cat /etc/issue
# Ubuntu 22.04.3 LTS \n \l


while IFS= read -r line; do
    # Extract the device ID
    id="$(echo "$line" | awk '{print $6}')"

    # Get the USB version
    usb_version="$(lsusb -v -d "$id" 2>/dev/null | grep -i "bcdUSB" | awk '{print $2}')"

    case "$usb_version" in
        "3.10")
            echo "$(echo "$line" | awk '{printf "%-27s", $4}') USB 3.1 Gen 1"
            ;;
        "3.00")
            echo "$(echo "$line" | awk '{printf "%-27s", $4}') USB 3.0"
            ;;
        "2.10")
            echo "$(echo "$line" | awk '{printf "%-27s", $4}') USB 2.1"
            ;;
        "2.00")
            echo "$(echo "$line" | awk '{printf "%-27s", $4}') USB 2.0"
            ;;
        "1.10")
            echo "$(echo "$line" | awk '{printf "%-27s", $4}') USB 1.1"
            ;;
        "1.00")
            echo "$(echo "$line" | awk '{printf "%-27s", $4}') USB 1.0"
            ;;
        *)
            echo "$(echo "$line" | awk '{printf "%-27s", $4}') Unknown USB Version"
            ;;
    esac
done < <(lsusb)
