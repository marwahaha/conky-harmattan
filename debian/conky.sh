#! /bin/sh +x

if [ -e /home/user/MyDocs/conky.conf ] 
then
    `which conky` -d -c /home/user/MyDocs/conky.conf
else
    `which conky` -d -c /etc/conky/conky.conf
fi