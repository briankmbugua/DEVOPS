#!/usr/bin/bash
MY_VARIABLE="some value"
echo $MY_VARIABLE
echo "Varibles can also be added within double-quoted strings:$MY_VARIABLE"
echo 'But not single-quoted strings. This will not read the varible: $MY_VARIABLE'
<<'COMMENT'
1. prefix the variable name with dollar $ sign while reading or printing a variable
2. Leave off the dollar sign while setting a variable with any value
3. A variable name may be alphanumeric or it may be written with and underscoe _
4. A variable name is case sensitive
5. There should not be whitespaces on either side of the equak sign between the variable name and its value
6. No need of using any quotes either single or double to define a variable with single character value.To input words or strings use qoutes for enclosing your content in that variable
7. Bash variables are untyped
TYPES OF BASH VARIABLES
1. System-Defined Variables - this are predefined variables and are maintained by the linux system itself.They are generally defined in capital letters
2.User-Defined Variables
COMMENT
#BASH
echo $BASH
#BASH_VERSION
echo $BASH_VERSION
#COLUMNS specify the bumber of columns for our screen
echo $COLUMNS
#HOME specify the home directory for the user
echo $HOME
#LOGNAME login user name
echo $LOGNAME
#OSTYPE
echo $OSTYPE
#PWD
#USERNAME specify the name of the currently logged in user
#To know the list of variables in the system use set, env and printenv

#USER DEFINED VARIABLES created and maintained by the user
name=peter
ROLL_NO=52345
echo "The student name is $name and his roll number is $ROLL_NO"
#Combining two string variables
Bash_var1="brian"
Bash_var2="mbugua"
echo "$Bash_var1$Bash_var2"
echo "My name is $Bash_var1$Bash_var2"