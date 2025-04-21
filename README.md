System Resource Monitor Script

This is a simple Bash script that monitors CPU, RAM, Disk usage, and system load average on a Linux server. If any usage exceeds the defined threshold, it logs the event and sends an email alert.

Features:

	•	Monitors:
	•	CPU usage
	•	RAM usage
	•	Disk usage
	•	System load average
	•	Sends email notifications when thresholds are exceeded
	•	Logs alerts to a file
	•	Lightweight and easy to schedule via cron

Configuration:

Before using the script, edit the following variables at the top of the file as needed:

CPU_LIMIT=80       # Maximum CPU usage allowed (%)

RAM_LIMIT=80       # Maximum RAM usage allowed (%)

DISK_LIMIT=80      # Maximum disk usage allowed (%)

LOG_FILE="/var/log/system_monitor.log"  # Log file path

ALERT_EMAIL="your@email.com"            # Alert recipient

Requirements:

	•	bash
	•	bc (for floating point arithmetic)
	•	mail command (install via mailutils or mailx)
	•	Permissions to read system stats and write to log file

Usage:

Make the script executable and run it manually or add it to cron:

chmod +x system_monitor.sh
./system_monitor.sh

Example Cron Job (every 5 minutes):

*/5 * * * * /path/to/system_monitor.sh

Output:
 
	•	Log entries are written to /var/log/system_monitor.log
	•	Email alerts will be sent to the configured address with relevant warning messages

Permissions:

Ensure the script has the necessary permissions to access system metrics and write logs:

sudo chmod +x system_monitor.sh

sudo touch /var/log/system_monitor.log

sudo chown $(whoami) /var/log/system_monitor.log

Notes:

	•	Adjust the SYSTEM_LOAD threshold in the script if your server has multiple CPUs (e.g., 1.5 might be normal on multi-core systems).
	•	The script assumes monitoring of the root (/) partition. Modify if needed to target specific mount points.
