#!bin/bash
echo Hello $(whoami)!
echo "--------------------------------------------------------------"

cpuUsage=$(top -bn1 | grep 'Cpu' | grep -E -o '[0-9.]+ id' | awk '{print $1}')

echo "CPU"
echo "Usage: $(echo "scale=2; 100 - $cpuUsage" | bc) %"

totalMem=$(top -bn1 | grep 'MiB Mem' | grep -E -o '[0-9.]+ total' | awk '{print $1}')
usedMem=$(top -bn1 | grep 'MiB Mem' | grep -E -o '[0-9.]+ used' | awk '{print $1}')
freeMem=$(top -bn1 | grep 'MiB Mem' | grep -E -o '[0-9.]+ free' | awk '{print $1}')

usedMemPercent=$(echo "scale=2; $usedMem/$totalMem * 100" | bc)
freeMemPercent=$(echo "scale=2; $freeMem/$totalMem * 100" | bc)

echo "---------------------------------------------------------------"
echo "MEMORY"
echo "Free:${freeMemPercent} %,		Used:${usedMemPercent} %"

diskLine=$(df --total | tail -n1)

diskSize=$(echo "$diskLine" | awk '{print $2}')
diskUsed=$(echo "$diskLine" |  awk '{print $3}')
diskAvail=$(echo "$diskLine" | awk '{print $4}')

diskUsedPercent=$(echo "scale=2; $diskUsed/$diskSize * 100" | bc)
diskAvailPercent=$(echo "scale=2; $diskAvail/$diskSize * 100" | bc)

echo "----------------------------------------------------------------"
echo 'DISK'
echo "SIZE: $(echo "scale=2; $diskSize/1024/1024" | bc)GB   |   FREE: $(echo "scale=2; $diskAvail/1024/1024" | bc)GB  -  $diskAvailPercent %   |   USED: $(echo "scale=2; $diskUsed/1024/1024" | bc)GB  -  $diskUsedPercent %"

echo "----------------------------------------------------------------"
