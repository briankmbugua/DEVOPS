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
1. System-Defined Variables
2.User-Defined Variables
COMMENT
