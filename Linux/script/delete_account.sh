#!/bin/bash
# delete system account
echo -e "Delete system account -v1.0"
echo -e "\nStep #1 Get username"
function get_answer {
	unset answer
	ask_count=0
	while [ -z "$answer" ]
	do
		ask_count=$[ $ask_count +1 ]
		case $ask_count in
			1|2)
				echo -en "\n$line"
				;;
			3)
				echo -en "\nOne last try...$line"
				;;
			4)
				echo -e "\nSince you refuse to  answer the question..."
				echo "exiting program."
				exit
				;;
		esac
		read -t 60 answer
	done
	unset line
}
line="Please enter the username of user: "
get_answer
user_account=$answer
user_account_color="\e[33m$answer\e[0m"

echo -e "\nStep #2 Confirm username"
line="you wish to delete \e[33m$user_account\e[0m from the system? [y/n]: "
get_answer
process_answer() {
	answer=$(echo $answer | cut -c1)
	case $answer in
		y|Y)
			;;
		n|N)
			echo "cancel delete user..."
			echo "exit..."
			exit
			;;
		*)
			echo "Unkonwn select, exit..."
			exit
			;;
	esac
}

echo -e "\nStep #3 Check user exists"
user_account_record=$(grep -w $user_account /etc/passwd)
if [ $? -eq 1 ]; then
	echo -e "$user_account_color not exist.."
	echo "exit..."
	exit
else
	echo -e "$user_account_color exist.."
fi


echo -e "\nStep #4 Kill user running processes"
ps -u $user_account >/dev/null
case $? in
	1)
		echo -e "There are no processes user $user_account_color"
		;;
	0)
		echo -e "$user_account_color has the following process(es) running:"
		ps -u $user_account
		line="Would you like kill the process(es)? [y/n]:"
		get_answer
		case $(echo $answer | cut -c1) in
			n|N)
				echo "skip kill running processes"
				;;
			y|Y)
				kill -9 $(ps -u$user_account -o pid=)
				;;
			*)
				;;
		esac
esac

echo -e "\nStep #5 Delete user files"
delete_account() {
	userdel -r $user_account &> /dev/null
	echo -e "User account, $user_account_color , has been removed !"
}

echo -e "\nStep #6 Remove user account"
line="Do you wish to remove $user_account_color's account from system? [y/n]: "
get_answer
case $(echo $answer | cut -c1) in
	n|N)
		echo "cancel Remove user account"
		;;
	y|Y)
		delete_account
		;;
esac
