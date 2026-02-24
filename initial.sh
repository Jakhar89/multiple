red=$'\e[1;31m'
grn=$'\e[1;32m'
reset=`tput sgr0`
echo "${grn}DOE BASH START $reset"

names='start-Author Build&Deploy start-Publisher QUIT'
PS3=$grn'Select Parameter:'
select name in $names
do
if [ $name == 'QUIT' ]

then
break
fi

if [ $name == 'Build&Deploy' ]
then
	./deploy.sh
fi

if [ $name == 'start-Author' ]

then
    echo " Starting $1"
    nohup ./start.sh && ./deploy.sh
fi

if [ $name == 'start-Publisher' ]

then
    echo " Starting $1"
    nohup ./publisher.sh && ./deploy.sh
fi

done
echo 'Quitting .. ...'
echo ''
