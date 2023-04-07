#!/usr/bin/bash
echo $0 # Prints the name of the script
echo $1 # prints the first argument given to a script
echo $2 # prints the second arguments given to a script
echo $# # prints the number of arguments given to a script
echo $@ # prints all the arguments passed to the script
echo $$ # prints the process ID
echo $? # prints the exit code of the previous process run