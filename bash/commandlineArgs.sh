#!/usr/bin/bash
# A shell script can take arguments on the command line.
echo "The script $0 evaluates to: " $(($1+$2))
# $0 specifies the name of the script to be invoked
# $1-$9 number of first 9 arguments
# $# total number of args passed to the string
# $* stores all command line arguments by joinining them togethor
# $@ stores the list of arguments as an array
# $? specifies the process ID of the current script
# $$ exit status of the last command or the most execution process
# $! shows ID of the last background job