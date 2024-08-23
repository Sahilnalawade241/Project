# System Resource Monitoring Script

This script monitors various system resources on a Linux server and displays them in a dashboard format.

## Usage

Run the script with the following command-line switches:

- `-cpu` : Display the top 10 CPU/Memory consuming applications.
- `-network` : Show network monitoring details.
- `-disk` : Display disk space usage.
- `-load` : Show system load average.
- `-memory` : Display memory usage details.
- `-processes` : Monitor active processes.
- `-services` : Check the status of essential services.

### Example:
```bash
./monitor.sh -cpu
