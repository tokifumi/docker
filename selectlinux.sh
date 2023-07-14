#!/bin/bash

while true
do
 echo "起動するLinuxを選択してください" 
 echo "c)CentOS"
 echo "u)Ubuntu"
 read ANS

 case $ANS in
	c)
	echo -e "CentOSを起動します\n"
	docker run --rm -it --name centos7 -h centos7 centos:7
	break
	;;

	u)
	echo -e "Ubuntuを起動します\n"
	docker run --rm -it --name ubuntu -h ubuntu ubuntu:latest
	break
	;;

	*)
	echo -e "cかuで選択してください\n"
	continue
	;;
 esac
done
