#!/bin/bash

ID="25438"
LOG_FILE="/usr/local/bin/dpkg_server_logs.txt"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

show_logs() {
    echo -e "\n$ID - $1:"
}

grep_logs() {
    local action=$1
    local date=$2
    if [ -n "$date" ]; then
        grep "$date" "$LOG_FILE" | grep "$action" | sed "s/^/$ID: /"
    else
        grep "$action" "$LOG_FILE" | sed "s/^/$ID: /"
    fi
}

summary() {
    local action=$1
    echo -e "\n$ID: $action Packages Summary:"
    grep "$action" "$LOG_FILE" | awk '{print $4}' | sort | uniq -c | sort -nr |
    while read -r count package; do
        echo " $count $package"
    done
}

while true; do
    echo "1. View All Logs"
    echo "2. Filter by Date"
    echo "3. Filter by Action"
    echo "4. Installed Packages Summary"
    echo "5. Upgraded Packages Summary"
    echo "6. Removed Packages Summary"
    echo "7. Exit"

    read -p "Choose an option: " option

    case "$option" in
        1)
            show_logs "All Logs"
            cat "$LOG_FILE" | sed "s/^/$ID: /"
            ;;
        2)
            read -p "Enter date (YYYY-MM-DD): " date
            show_logs "Logs for $date"
            grep "$date" "$LOG_FILE" | sed "s/^/$ID: /"
            ;;
        3)
            read -p "Enter action (install, upgrade, remove): " action
            show_logs "Logs for $action"
            grep_logs "$action" ""
            ;;
        4)
            show_logs "Installed Packages Summary"
            summary "install"
            ;;
        5)
            show_logs "Upgraded Packages Summary"
            summary "upgrade"
            ;;
        6)
            show_logs "Removed Packages Summary"
            summary "remove"
            ;;
        7)
            exit 0
            ;;
        *)
            echo "Invalid option. Try again."
            ;;
    esac
done
