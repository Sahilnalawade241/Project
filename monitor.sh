top_apps() {
    echo "Top 10 CPU/Memory Consuming Applications:"
    ps aux --sort=-%cpu,-%mem | head -n 11
}
network_monitor() {
    echo "Network Monitoring:"
    echo "Concurrent Connections: $(netstat -an | grep ESTABLISHED | wc -l)"
    echo "Packet Drops: $(netstat -s | grep 'packet receive errors')"
    echo "Network I/O:"
    ifstat -i eth0 1 1 | awk 'NR==3 {print "In: "$1 " KB, Out: "$2 " KB"}'
}
disk_usage() {
    echo "Disk Usage:"
    df -h | awk '$5 > 80 {print $0 " <- Warning: Over 80% Usage!"} $5 <= 80 {print $0}'
}

system_load() {
    echo "System Load:"
    echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
    mpstat | awk '$12 ~ /[0-9.]+/ { print "User: "$3"% System: "$5"% Idle: "$12"%"}'
}
memory_usage() {
    echo "Memory Usage:"
    free -h | awk '/^Mem:/ {print "Total: "$2 ", Used: "$3 ", Free: "$4}'
    free -h | awk '/^Swap:/ {print "Swap - Total: "$2 ", Used: "$3 ", Free: "$4}'
}
process_monitor() {
    echo "Process Monitoring:"
    echo "Total Active Processes: $(ps aux | wc -l)"
    echo "Top 5 CPU/Memory Consuming Processes:"
    ps aux --sort=-%cpu,-%mem | head -n 6
}
service_monitor() {
    echo "Service Monitoring:"
    for service in sshd nginx iptables; do
        if systemctl is-active --quiet $service; then
            echo "$service is running."
        else
            echo "$service is not running!"
        fi
    done
}

while [ "$1" != "" ]; do
    case $1 in
        -cpu ) top_apps ;;
        -network ) network_monitor ;;
        -disk ) disk_usage ;;
        -load ) system_load ;;
        -memory ) memory_usage ;;
        -processes ) process_monitor ;;
        -services ) service_monitor ;;
        * ) echo "Invalid option: $1" ;;
    esac
    shift
done

