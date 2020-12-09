#!/bin/bash

hoursFromNow=6
minutesFromNow=15

# Check for command line arguments
if [ $# -ge "1" ]; then
  # Help
  if [[ "$1" == "--help" ]]; then
    echo "Usage: ./spotify-alarm.sh [-o] [option #]"
    echo "Options: [1] 4.5 hours; [2] 6 hours; [3] 7.5 hours"
    echo "Example: ./spotify-alarm.sh -o 2"
    exit
  fi

  # Option
  if [[ "$1" == "-o" ]]; then
    if [[ -z "$2" ]]; then # No argument
      echo "Please specify an option. Do ./spotify-alarm.sh --help for help."
      exit
    fi

    if [[ "$2" == "1" ]]; then
      hoursFromNow=4
      minutesFromNow=45
    fi
    if [[ "$2" == "3" ]]; then
      hoursFromNow=7
      minutesFromNow=45
    fi
  fi

  if [[ "$1" == "-h" ]]; then
    hoursFromNow="$2"
    minutesFromNow=0
  fi

  if [[ "$1" == "-m" ]]; then
    hoursFromNow=0
    minutesFromNow="$2"
  fi
fi

alarmDatetime=`date -d "+$hoursFromNow hour +$minutesFromNow minute"`

while true
do
  datetimeNow=`date`
  if [[ "$alarmDatetime" == "$datetimeNow" ]]; then
    break
  fi
  sleep 1
done

xdotool key Control_L+Shift_L+n
sleep 1
xdotool type 'ncspot'
xdotool key Return
sleep 3
xdotool key F2
xdotool key Down
xdotool key Right
xdotool key Right
xdotool key Right
xdotool key Up
xdotool type 'Wake Up Music'
xdotool key Return
xdotool key Down
sleep 0.5
xdotool key z

for (( i=0; i<70; i++)); do
  xdotool key minus
done

xdotool key Return

# Gradually increase the volume up to 100%
for (( i=0; i<70; i++ )); do
  sleep 0.2
  xdotool key plus
#  spotify volume up 10
done
