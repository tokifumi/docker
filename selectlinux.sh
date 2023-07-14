#!/bin/bash

while true
do
 echo "起動するLinuxを選択してください" 
 echo "1)CentOS"
 echo "2)Ubuntu"
 read -p "1か2で選択してください： " ANS

 case $ANS in
	1)
	echo -e "CentOSを起動します\n"
	docker run --rm -it --name centos7-$(date +%s) -h centos7 centos:7
	break
	;;

	2)
	echo -e "Ubuntuを起動します\n"
	docker run --rm -it --name ubuntu-$(date +%s) -h ubuntu ubuntu:latest
	break
	;;

	*)
	echo -e "無効な選択肢です\n"
	continue
	;;
 esac
done
