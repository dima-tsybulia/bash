#! /bin/bash
# Written by Dmitry Tsybulia
# For personal use only (Softheme Internship)
# v.0.0.5 - 07/27/2017

echo "Enter N:"
read array_size
echo "Enter D:"
read divider 
for ((i=1; i <= $array_size; i++))
do
	echo "Enter $i element:"
	read number
	result=$(echo "scale = 2; $number / $divider" | bc)
	array=("${array[@]}" $result)	
done
echo "Result array:"
for ((i=0; i < ${#array[@]}; i++))
do
	index=$(($i+1))
	echo "$index # ${array[$i]}"
done
