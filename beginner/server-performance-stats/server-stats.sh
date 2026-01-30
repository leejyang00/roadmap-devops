#!/bin/bash

# multipass launch --name test-server --cpus 2 --memory 2G --disk 10G
# multipass mount ./server-performance-stats test-server:/home/ubuntu/scripts
# bash server-stats.sh inside the instance
# or multipass exec test-server -- bash /home/ubuntu/scripts/server-stats.sh

echo "Starting server performance stats collection..."

# 1. Total CPU usage -b batch -n iterations 
echo "Total CPU Usage:"
cpu_idle=$(top -bn2 -d 0.5 | grep "Cpu(s)" | awk '{print "CPU Usage:", 100 - $8 "%"}' | tail -1) 
echo "$cpu_idle"

printf "\n"

# 2. Total memory usage (Free vs Used including percentage)
echo "Total memory usage (Free vs Used including percentage):"
read -r total used free <<< $(free | grep "Mem:" | awk '{print $2, $3, $4}')
echo "Memory Usage: Used: $used KB, Free: $free KB, Total: $total KB"
used_percent=$(echo "scale=2; $used*100/$total" | bc)
echo "Memory Usage Percentage: $used_percent%"
free_percent=$(echo "scale=2; $free*100/$total" | bc)
echo "Memory Free Percentage: $free_percent%"

printf "\n"

# 3. Total disk usage (Free vs Used including percentage)
echo "Total disk usage (Free vs Used including percentage):"
read -r disk_total disk_used disk_free <<< $(df --block-size=K / | tail -1 | awk '{print $2, $3, $4}')
disk_used_percent=$(echo "scale=2; $disk_used*100/$disk_total" | bc)
echo "Disk Usage Percentage: $disk_used_percent%"
disk_free_percent=$(echo "scale=2; $disk_free*100/$disk_total" | bc)
echo "Disk Free Percentage: $disk_free_percent%"

printf "\n"

# 4. Top 5 processes by CPU usage
echo "Top 5 processes by CPU usage:"
# slower way:
# top_output=$(top -bn2 -d 0.5)
# echo "$top_output" | grep "PID" | tail -1
# top -bn2 -d 0.5 | awk '/PID / {i++} i==2' | sort -k9 -nr | head -n 5

# faster way:
ps -eo pid,user,%cpu,%mem,command --sort=-%cpu | head -n 6

# 5. Top 5 processes by memory usage
echo "Top 5 processes by memory usage:"
ps -eo pid,user,%cpu,%mem,command --sort=-%mem | head -n 6