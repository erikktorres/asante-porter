#!/bin/bash

# Asante Diabetes Manage System Communication Protocol Requirements - PORTER
PREFIX="ttyUSB.AsantePorter"
search="/dev/${PREFIX}*"
num=$(find $search 2>/dev/null | wc -l)
name="${PREFIX}${num}"
logger -t 'asante-porter' -- "$1 $2 $3"
logger -t 'asante-porter' -- "/dev/$name"
echo $name

