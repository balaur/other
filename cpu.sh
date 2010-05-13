#!/bin/bash

j=0
for i in `cat /proc/cpuinfo | grep bogomips |  awk '{ print $3}'`; do 
    j=`echo $j+$i | bc`
done

echo $j
