#!/bin/bash

#CPU Usage
cpu_usage=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $cpu_usage%"

#top 5 processes by CPU usage
top_processes=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $1, $2, $3, $4, $5}')
echo "Top 5 Processes by CPU Usage: $top_processes"

#top 5 processes by memory usage
top_processes_mem=$(top -b -n 1 -o %MEM | awk 'NR>7 {print "PID: "$1, "Process: "$12, "Memory: "$10}' | head -n 5)
echo "Top 5 Processes by Memory Usage: $top_processes_mem"

#memory usage
read total used free <<< $(free -m | awk 'NR==2 {print $2, $3, $4}')

used_percent=$(( used * 100 / total ))
free_percent=$(( free * 100 / total ))

echo "Memory Total: ${total}MB"
echo "Memory Used: ${used}MB (${used_percent}%)"
echo "Memory Free: ${free}MB (${free_percent}%)"

#disk usage
read size used avail use_percent <<< $(df -m / | awk 'NR==2 {print $2, $3, $4, $5}')

use_percent_num=${use_percent%\%}

free_percent=$((100 - use_percent_num))

echo "Disk Total: ${size}MB"
echo "Disk Used: ${used}MB (${use_percent_num}%)"
echo "Disk Free: ${avail}MB (${free_percent}%)"


#network usage
net_usage=$(ip -s link show eth0 | awk '/RX:/ {getline; rx=$1} /TX:/ {getline; tx=$1} END {print "RX:", rx, "TX:", tx}')
echo "Network Usage: $net_usage"

