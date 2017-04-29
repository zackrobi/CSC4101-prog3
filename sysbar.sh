#!/bin/bash

#Name: Rrobicheaux, Zachary
#Project: PA-3 (Shell Programming)
#File: sysbar.sh
#Instructor: Feng Chen
#Class: cs4103-sp17
#LoginID: cs410380


interval=$1
collections=$2

testfile() {
  if [$1 = "help"]; then
    #write help info (Explain the reasonable range of arguements, the arguements, and the output)
  else
    if [$# -gt 2]; then
      echo "Too many arguements"
      exit
    elif [$# -lt 2]; then
      echo "Not enough arguements"
      exit
    else
      if [[$1 -gt 99 || $2 -gt 99 || $1 -lt 2 || $2 -lt 2]]
        echo "Arguements aren't within range"
        exit
      fi
    fi
  fi
}

gatherdiskusage() {
  local i=0
  local items=(
}

gathercpuusage() {
  local i=1
  let local limit = $collections+1
  local items=($(mpstat $interval $collections))
  while [$i -lt $limit]; do
     echo -n ${items[$i]} | awk '{print $1;}' >> cpu_usage.plot #takes the datetime for the first iteration and add it to the file 
     echo -n " " >> cpu_usgae.plot
     echo -n ${items[$i]} | awk '{print $4;}' >> cpu_usage.plot
     echo -n " " >> cpu_usgae.plot
     echo -n ${items[$i]} | awk '{print $6;}' >> cpu_usage.plot
     echo -n " " >> cpu_usgae.plot
     echo  ${items[$i]} | awk '{print $13;}' >> cpu_usage.plot
  done
  perl bargraph.pl cpu_usage.plot cpu_usage.eps
}

setupplots() {
  echo -e "=stacked; usr; sys; idle\ntitle=CPU Utilization\ncolors=red,blue,green\nxlabel=Time of Data Collection\nylabel=Percentage (%)" > cpu_usage.plot
  echo -e "=table\n=norotate\nyformat=%g\n" >> cpu_usage.plot
  echo -e "=stacked; kB_read/s; kB_wrtn/s\ntitle=Disk Utilization\ncolors=orange,yellow\nxlabel=Time of Data Collection\nylabel=Bandwidth (kB/sec)" > disk_usage.plot
  echo -e "=table\n=norotate\nyformat=%g\n" >> disk_usage.plot
  #Need function call for gatherdiskusage & gathercpuusage
}

testfile $#



