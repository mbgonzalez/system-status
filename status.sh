#!/bin/bash

#get space
disk_space=$(df -h / | awk 'NR==2 {print $2,$3,$4}')
used_space=$(echo $disk_space | awk '{print $2}')
free_space=$(echo $disk_space | awk '{print $3}')

#get ram
total_ram=$(free -h | awk '/^Mem:/ {print $2}')
used_ram=$(free -h | awk '/^Mem:/ {print $3}')
percent_used=$(echo $disk_space | awk '{print $2/$3 * 100}')
percent_ram=$(free | awk '/^Mem:/ {print $3/$2 * 100.0}' | cut -c1-4)

# get cpu
cpu_info=$(lscpu | awk '/^Model name:/ {$1=""; print}')
cpu_cores=$(lscpu | awk '/^CPU\(s\):/ {print $2}')
cpu_speed=$(lscpu | awk '/^CPU MHz:/ {print $3}')
cpu_percent=$(top -bn1 | awk '/^%Cpu/{printf "%.2f%%", $2+$4}')

#output
echo "---------------------------------------------------------"
echo "----------------------SYSTEM-STATUS----------------------"
echo "---------------------------------------------------------"
echo " - Espacio en disco utilizado: $used_space GB"
echo " - Espacio en disco libre: $free_space GB"
echo " - Porcentaje de espacio en disco utilizado: $percent_used%"
echo "---------------------------------------------------------"
echo " - RAM utilizada: $used_ram / $total_ram GB"
echo " - Porcentaje de RAM utilizada: $percent_ram%"
echo "---------------------------------------------------------"
echo " - Información de la CPU:"
echo " - Modelo: $cpu_info"
echo " - Número de cores: $cpu_cores"
echo " - Velocidad de los cores: $cpu_speed MHz"
echo " - Porcentaje de uso de CPU: $cpu_percent"
echo "---------------------------------------------------------"
