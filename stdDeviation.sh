#!/bin/sh

STD_DEVIATION_FILE="/tmp/stdDeviation.txt" # This file will contain the values to compute standard deviation

# Clean workspace
[ -e "$STD_DEVIATION_FILE" ] && rm "$STD_DEVIATION_FILE"

# Initialize workspace:
# Create a datafile example
# This example was got from https://www.statcan.gc.ca/edu/power-pouvoir/ch12/5214891-fra.htm#a3
echo 60 >> $STD_DEVIATION_FILE
echo 56 >> $STD_DEVIATION_FILE
echo 61 >> $STD_DEVIATION_FILE
echo 68 >> $STD_DEVIATION_FILE
echo 51 >> $STD_DEVIATION_FILE
echo 53 >> $STD_DEVIATION_FILE
echo 69 >> $STD_DEVIATION_FILE
echo 54 >> $STD_DEVIATION_FILE

# First step: Get the mean
MEAN=$(awk '{

        sum+=$1;

    } END {printf "%f", sum/FNR}' $STD_DEVIATION_FILE)

# Second step: Compute Standard Deviation
awk -v mean=$MEAN '{
        intermediate_step+=($1-mean)*($1-mean)
        sum+=$1;
        sumsq+=$1*$1

    } END {printf "%f\n", sqrt(intermediate_step / FNR)}' $STD_DEVIATION_FILE
