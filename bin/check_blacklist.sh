i=0;
while read -r line; do
#    echo "... $line ..."
        (( i += 1 ))
done < "/etc/zabbix/tmp/blacklist"
echo $i;
