#!/usr/bin/env bash
user=${USER^}
c="\e[0m"
c1="\e[34;1m"
c2="\e[32;1m"

# Welcome
printf "${c1}Welcome back, "$user"${c}\n"

# Date
day=$(date +"%A")
mon=$(date +"%B")
date=$(date +"%d")
year=$(date +"%Y")
suffix=""

pat="([0-9])([0-9])"
if [[ $date =~ $pat ]]
then
	d2=${BASH_REMATCH[2]}
	
	case $d2 in
		1*)
			suffix="st"
			;;
		2*)
			suffix="nd"
			;;
		*)
			suffix="th"
			;;
	esac
fi

printf "It is \e[1m$day${c} the $date$suffix of $mon, $year.\n" 

# Tasks
tasks=$(task +TODAY list 2>/dev/null)
if [[ ! $tasks ]]; then
	printf "You have no tasks due today.\n"
else
	tasks=$(task +TODAY list | wc -l)
	tasks=$(expr $tasks - 5)
	if [ $tasks == "1" ]
	then
		printf "\e[3mYou have ${c}${c2}1${c}\e[3m task due today.${c}\n\n"
		read -p 'Would you like to view the task? [y/N]: ' input
		if [[ $input == 'y' || input == 'Y' || input == 'yes' || input == '' ]]; then
			task +TODAY next
		else
			printf "\nEnjoy your session.\n"
		fi

	else
		printf "\e[3mYou have ${c}${c2}"$tasks"${c}\e[3m tasks due today.${c}\n\n"
		read -p 'Would you like to view the tasks? [y/N]: ' input
		if [[ $input == 'y' || input == 'Y' || input == 'yes' || input == '' ]]; then
			task +TODAY next
		else
			printf "\nEnjoy your session.\n"
		fi
	fi
fi

echo
