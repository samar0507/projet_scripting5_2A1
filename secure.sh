#!/bin/bash
function show_usage()
{
echo "log.sh :  [-h] [-g] [-m] [-c] [-a] [-b] [-l] "
}
function argument  
{
if [ $# -eq "0" ]  
then
show_usage  
echo "erreur:PAS D ARGUMENT PASSÉ AU SCRIPT!!!"
fi
}
function Connexion()
{
	echo " les utilisateurs qui ont tenté de se connecté sont"
	sudo cat /var/log/secure |grep failure | rev|cut -d ' ' -d'=' -f 1 |rev|uniq
}
function alert()
{
	echo "le nombre de mauvaises tentatives de connexion est"
  	sudo cat /var/log/secure | grep "failure" | wc -l 
	if (a=$(sudo cat /var/log/secure | grep " failure" | wc -l) >3); then
		echo "Alert"
	else
		echo "no alert"
	fi
}

function service()
{ 
	echo "les services qui sont entrain de demarrer sont "
	sudo cat /var/log/boot.log |grep Starting| cut -d ':' -f 1| cut -d ' ' -f 2,3
}
function HELP()
{
	cat HELP.txt
}
function mail()
{
	 echo "la derniere date dacces au service mail est" 
	 sudo tail -1 /var/log/maillog | cut -d ' ' -f -4
}
function menut()
{
	while [[ $choix -ne 6 ]]
	do 
		echo "*********************MENU*****************"
		echo "1) ----- Tentatives de connexions"
		echo "2) ----- Traçage du dernier  mailing"
		echo "3) ----- Starting name servers"
		echo "4) ----- Alert des tentatives de tros"
		echo "5) ----- Help"
		echo "6) ----- Quitter"
		echo "******************************************"
		read -p "Donnez votre choix:" choix
		clear
		case $choix in 
			1)Connexion ;;
			2)mail ;;
			3)service ;;
			4)alert;;
			5)HELP;;
			6)exit 1 ;;
		        *)echo "Mauvais choix : spécifier un nombre entre 1 et 6 "
		  esac
      done
}
while getopts "hmgclab" option  #analyser les options passes en argument
 do
	 case $option in
	        h)
        	HELP
        	exit 0
        	;;
        	m)
        	menut
        	exit 0
        	;;
        	g)
        	exit 0
        	;;
        	c)
        	Connexion 
        	exit 0
        	;;
        	l) 
        	mail
        	exit 0
        	;;
       		a) 
        	alert $2
        	exit 0
        	;;
        	b)
        	service
        	exit 0
        	;;	
        	*)
        	echo "invalid option"
        	exit 0
        	;;

	esac 
done
argument
exit 0

