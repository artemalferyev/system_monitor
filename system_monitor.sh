#!/bin/bash

# Set threshold values for alerts (adjust as needed)
CPU_LIMIT=80
RAM_LIMIT=80
DISK_LIMIT=80
LOG_FILE="/var/log/system_monitor.log"
ALERT_EMAIL="your@email.com"

# Get current system stats
CPU_LOAD=$(top -bn1 | awk '/Cpu\(s\)/ {print $2 + $4}')  # User + System CPU usage
RAM_LOAD=$(free | awk '/Mem:/ {printf("%.2f", $3/$2 * 100)}')  # RAM usage in %
DISK_LOAD=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')  # Disk usage in %
SYSTEM_LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1)  # Load average
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Function to log events and send alerts
send_alert() {
    MESSAGE="$1"
    echo "$CURRENT_TIME - $MESSAGE" | tee -a "$LOG_FILE"

    # Send email alert (mailutils must be installed)
    echo "$MESSAGE" | mail -s "⚠️ System Alert on $(hostname)" "$ALERT_EMAIL"
}

# Check CPU usage
if (( $(echo "$CPU_LOAD > $CPU_LIMIT" | bc -l) )); then
    send_alert "Warning: High CPU usage detected (${CPU_LOAD}%)"
fi

# Check RAM usage
if (( $(echo "$RAM_LOAD > $RAM_LIMIT" | bc -l) )); then
    send_alert "Warning: High RAM usage detected (${RAM_LOAD}%)"
fi

# Check Disk usage
if [ "$DISK_LOAD" -gt "$DISK_LIMIT" ]; then
    send_alert "Warning: Disk space usage is high (${DISK_LOAD}%)"
fi

# Check system load average
if (( $(echo "$SYSTEM_LOAD > 1.5" | bc -l) )); then
    send_alert "System Load is high: ${SYSTEM_LOAD}"
fi

exit 0
