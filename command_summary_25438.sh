#!/bin/bash

ID="25438"
NAME="KWIZERA Alain Bertrand"

LOG_FILE="command_selection_log.txt"

function display_menu {
     clear
echo "==========================="
echo "command summary menu"
echo "==========================="
  echo "current date: $(date)"

   echo "student id: $ID"
   echo "full name: $NAME"
    echo "select a command to learn more:"
     echo "1. pwd"
     echo "2. ls"
     echo "3. cd"
     echo "4. mkdir"
     echo "5. rm"
     echo "0. Exit"
}

function log_selection {
       echo "$ID $(date +"%Y-%m-%d %H:%M:%S") - command selected:
$1" >> "$LOG_FILE"
}

while true; do 
     display_menu
     read -p "Enter your choice (0-5): " choice

     case $choice in 
      1)
        log_selection "pwd"
            echo -e "\nCommand: pwd\nDescription: Prints the current working directory.\nSyntax: pwd\nExample: pwd\nCommon Options: None\n"
            ;;
        2)
            log_selection "ls"
            echo -e "\nCommand: ls\nDescription: Lists files and directories.\nSyntax: ls [options] [directory]\nExample: ls -la\nCommon Options: -l (long format), -a (show hidden files)\n"
            ;;
        3)
            log_selection "cd"
            echo -e "\nCommand: cd\nPurpose: Changes the current directory.\nSyntax: cd [directory]\nExample: cd /home/user\nCommon Options: None\n"
            ;;
        4)
            log_selection "mkdir"
            echo -e "\nCommand: mkdir\nPurpose: Creates a new directory.\nSyntax: mkdir [options] directory\nExample: mkdir new_folder\nCommon Options: -p (create parent directories)\n"
            ;;
        5)
           log_selection "rm"
            echo -e "\nCommand: rm\nPurpose: Removes files or directories.\nSyntax: rm [options] file\nExample: rm file.txt\nCommon Options: -r (recursive), -f (force)\n"
            ;;
        0)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please enter a number between 0 and 5."
            ;;
    esac
    read -p "Press Enter to continue..."
done 

