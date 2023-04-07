#!/usr/bin/bash
MY_VARIABLE="some value"
echo $MY_VARIABLE
echo "Varibles can also be added within double-quoted strings:$MY_VARIABLE"
echo 'But not single-quoted strings. This will not read the varible: $MY_VARIABLE'