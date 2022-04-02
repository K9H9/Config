#!/bin/sh

user="$USER""@"
distro=$(cat /etc/os-release |  grep "PRETTY_NAME" |cut -d "=" -f 2 | cut -d '"' -f 2)
host="Lenovo Legion 5"
kernel=$(uname -r)
wm="$(xprop -id $(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}') -notype -f _NET_WM_NAME 8t | grep "WM_NAME" | cut -f2 -d \")"
pkgs=$(pacman -Q | wc -l)
memory="$(free --mega | grep Mem | awk '{print $3/1000}' | cut -c 1-3 ) Gb / $(free --mega | grep Mem | awk '{print $2/1000}' | cut -c 1-4) Gb"
shell="$(basename ${SHELL})"
cpu=$(vmstat | tail -1 | awk '{printf "%d", 100-$15}')
disk="$(df -kH -B 1GB /dev/nvme0n1p6 | tail -1 | cut -d " " -f 13) Gb / $(echo "$(df -kH -B 1GB /dev/nvme0n1p6 | tail -1 | cut -d " " -f 13)+$(df -kH -B 1GB /dev/nvme0n1p6 | tail -1 | cut -d " " -f 20)" | bc) Gb"
# diskavailable=$(echo "$(df -kH -B 1GB /dev/nvme0n1p6 | tail -1 | cut -d " " -f 13)+$(df -kH -B 1GB /dev/nvme0n1p6 | tail -1 | cut -d " " -f 20)" | bc)
# diskused=$(df -kH -B 1GB /dev/nvme0n1p6 | tail -1 | cut -d " " -f 13)
# times=" mins"
cpufreq=$(sum=0 ; count=0 ; for cpu in $(cat /proc/cpuinfo | grep "MHz" | cut -d ":" -f 2); do ; number=$(($cpu)) ; count=$((count + 1)) ; sum=$((sum + number)) ; done ;  echo "$sum/$count" | bc)
stat="$cpu% - $cpufreq"MHz""
uptime=$(if [[ $(uptime -p | wc -w) == 5 ]]; then
    echo ""$(uptime -p | cut -d " " -f 2-4) "mins"
else
    echo "$(uptime -p | cut -d " " -f 2-)"
fi)

# echo "        $user"
# echo ' '
# echo "Os: $distro"
# echo "Host: $host"
# echo "Shell: $shell"
# echo "Kernel: $kernel"
# echo "Wm: $wm"
# if [[ $(uptime -p | wc -w) == 5 ]]; then
#     echo ""Uptime: "$(uptime -p | cut -d " " -f 2-4) "mins""
# else
#     echo ""Uptime: "$(uptime -p | cut -d " " -f 2-)" 
# fi
# echo "Pkgs: $pkgs (pacman)"
# echo "Memory: "$used Gb/$available Gb""
# echo "Cpu: $stat" 
# echo "Disk: $diskused "Gb" "/" $diskavailable "Gb""
printf '%b' "  
        $user

Os: $distro
Host: $host
Kernel: $kernel
Shell: $shell
Wm: $wm
Uptime: $uptime
Pkgs: $pkgs
Memory: $memory
Cpu: $stat

"


