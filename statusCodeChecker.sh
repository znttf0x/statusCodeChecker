#!/bin/bash

#colors
reset="\033[0m"
yellow="\033[0;33m"

#infoTab
if [[ -z $1 || "$1" == "-h" ]]; then
	echo -e ""
	echo -e "${yellow}Programa:${reset}            statusCodechecker.sh"
	echo -e "${yellow}Criado em:${reset}           07/07/2021"
	echo -e "${yellow}Ultima modificacao:${reset}  08/07/2021"
	echo -e "${yellow}Autoria:${reset}             Lucas Zanoti"
	echo -e "${yellow}Email:${reset}               lucaszanotti1997@gmail.com"
	echo -e "${yellow}Discord:${reset}             /zntt#7359"
	echo -e ""
	echo -e "${yellow}Opções:${reset}              [-h. --help] Para acessar o menu de ajuda."
	echo -e "${yellow}Uso:${reset}                 ./statusCodeChecker.sh www.link.com.br /wordlist/directory"
	exit
fi

#theProgram
echo -e "${yellow}CODE URL${reset}"
total=$(wc -l $2 | cut -d " " -f 1)
attempt="1"
for dir in $(cat $2); do
	echo -e "${yellow}Attempt: $attempt/$total${reset}"
	statuscode=$(curl -s --head -L $1/$dir/ | grep "HTTP" | cut -d " " -f 2 | tail -n 1)
	let "attempt++"
	echo -e "\e[1A\e[1K\c"
	if [[ "$statuscode" == "200" ]]; then
		echo -e "$statuscode $1/$dir" | tr " " \\t | column -t -s$'\t'
	fi
done
