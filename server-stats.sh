#!bin/bash
echo Hello $(whoami)!
value=$(top -bn1 | grep 'Cpu' | grep -E -o '[0-9.]+ id' | awk '{print $1}')
echo "The current Total CPU Usage is $(echo "scale=2; 100 - $value" | bc)%"
