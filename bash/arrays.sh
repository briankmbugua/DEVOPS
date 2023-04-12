#!/usr/bin/bash
#arrays in bash
my_array=(1,2,3)
echo ${my_array[0]}
# @ charcter in bash
# @ represents all the positional parameters starting from $1.
# Example "script.sh arg1 arg2 arg3" then the special character "@" would be equal to "arg1 arg2 arg3"
# @ symbol can also be used as a wildcard character in globbing patterns.Example ".txt" would match all files with extension ".txt" while "file@" would match all files that start with "file" and have any number of characters after it.