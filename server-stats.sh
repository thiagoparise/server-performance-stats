#!bin/bash
echo Hello $(whoami)!

cpuUsage=$(top -bn1 | grep 'Cpu' | grep -E -o '[0-9.]+ id' | awk '{print $1}')
echo "The current Total CPU Usage is $(echo "scale=2; 100 - $cpuUsage" | bc)%"

totalMem=$(top -bn1 | grep 'MiB Mem' | grep -E -o '[0-9.]+ total' | awk '{print $1}')
usedMem=$(top -bn1 | grep 'MiB Mem' | grep -E -o '[0-9.]+ used' | awk '{print $1}')
freeMem=$(top -bn1 | grep 'MiB Mem' | grep -E -o '[0-9.]+ free' | awk '{print $1}')

usedMemPercent=$(echo "scale=2; $usedMem/$totalMem * 100" | bc)
freeMemPercent=$(echo "scale=2; $freeMem/$totalMem * 100" | bc)

echo "The current Memory Usage is. Free:"${freeMemPercent}"%, Used:"${usedMemPercent}"%"
