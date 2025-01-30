#!/bin/bash
# ========================Start Disk Usage ====================

monitor_disk_usage(){

# capture the disk usage percent from root user

disk_usage=$(df --output=pcent / | tail -1 | tr -d ' %')

# print percent

echo "=======Disk=========="
echo "Disk usage : $disk_usage% "

# give warning when usage above 80 

if [ $disk_usage -gt 80 ]
then
  echo "Warning! disk usage is above 80% "
# send warining mail
  echo "sending email....."
  echo "Warning: Disk usage exceeded 80%. Please take proper actions." | mail -s "Disk Usage Warning" -a "From: Monitor System <om03991@gmail.com>" om039919@gmail.com
fi

}

# ========================End Disk Usage ====================


# ========================Start CPU Usage ====================

monitor_CPU_usage(){

# capture the CPU usage

CPU_usage=$(top -bn1 | awk '/Cpu/ {print 100-$8}')

# print percent

echo "=======CPU=========="
echo "current CPU : $CPU_usage% "

}


# ========================End CPU Usage ====================

# ========================Start Memory Usage ====================

monitor_Mem_usage(){

# capture the mem usage :- Total,used,free
memory=$(free -h | awk 'NR==2 {printf "Total : %s , Used : %s , Free : %s\n", $2,$3,$4}')


# print memory usuage

echo "=======memrory=========="
echo "Memory : $memory "

}

# ========================End Memory Usage ====================


# ========================Start TOP 5 ====================

monitor_top_five(){

# capture the top five using memory process
top_five=$(ps -eo pid,user,%mem,command --sort=-%mem | head -n 6)


# print memory usuage

echo "=======Top Five Using Memory Processes=========="
echo "$top_five"

}
# ========================End TOP 5 ====================


#==================GENERATE REPORT =========================
gen_report(){
echo "==================Monitor Report========================================"
echo "Reported at :"
date
monitor_disk_usage
monitor_CPU_usage
monitor_Mem_usage
monitor_top_five
}
gen_report


