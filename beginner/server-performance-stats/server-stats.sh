#!/bin/bash

# multipass launch --name test-server --cpus 2 --memory 2G --disk 10G
# multipass mount ./server-performance-stats test-server:/home/ubuntu/scripts
# bash server-stats.sh inside the instance
# or multipass exec test-server -- bash /home/ubuntu/scripts/server-stats.sh

echo "Starting server performance stats collection..."
uptime

# 1. Total CPU usage -b batch -n iterations 
echo "Total CPU Usage:"
cpu_idle=$(top -bn2 -d 0.5 | grep "Cpu(s)" | awk '{print "CPU Usage:", 100 - $8 "%"}' | tail -1) 
echo "$cpu_idle"

# solution:
# top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'

printf "\n"

# 2. Total memory usage (Free vs Used including percentage)
echo "Total memory usage (Free vs Used including percentage):"
read -r total used free <<< $(free | grep "Mem:" | awk '{print $2, $3, $4}')
echo "Memory Usage: Used: $used KB, Free: $free KB, Total: $total KB"
used_percent=$(echo "scale=2; $used*100/$total" | bc)
echo "Memory Usage Percentage: $used_percent%"
free_percent=$(echo "scale=2; $free*100/$total" | bc)
echo "Memory Free Percentage: $free_percent%"

# solution: 
# free | grep "Mem:" -w | awk '{printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'

printf "\n"

# 3. Total disk usage (Free vs Used including percentage)
echo "Total disk usage (Free vs Used including percentage):"
read -r disk_total disk_used disk_free <<< $(df --block-size=K / | tail -1 | awk '{print $2, $3, $4}')
disk_used_percent=$(echo "scale=2; $disk_used*100/$disk_total" | bc)
echo "Disk Usage Percentage: $disk_used_percent%"
disk_free_percent=$(echo "scale=2; $disk_free*100/$disk_total" | bc)
echo "Disk Free Percentage: $disk_free_percent%"

# solution:
# df -h | grep "/" -w | awk '{printf "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'

printf "\n"

# 4. Top 5 processes by CPU usage
echo "Top 5 processes by CPU usage:"
# slower way:
# top_output=$(top -bn2 -d 0.5)
# echo "$top_output" | grep "PID" | tail -1
# top -bn2 -d 0.5 | awk '/PID / {i++} i==2' | sort -k9 -nr | head -n 5

# faster way:
ps -eo pid,user,%cpu,%mem,command --sort=-%cpu | head -n 6
# solution: ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'

# 5. Top 5 processes by memory usage
echo "Top 5 processes by memory usage:"
ps -eo pid,user,%cpu,%mem,command --sort=-%mem | head -n 6
# solution: ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'