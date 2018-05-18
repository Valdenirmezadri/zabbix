cat /etc/redhat-release |grep 6 && test $? && rpm -Uvh http://repo.zabbix.com/zabbix/3.4/rhel/6/x86_64/zabbix-release-3.4-1.el6.noarch.rpm || echo 'não é CentOS 6';
cat /etc/redhat-release |grep 7 && test $? && rpm -Uvh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm || echo 'não é CentOS 7'; 
cat /etc/redhat-release |grep 5 && test $? && rpm -Uvh http://repo.zabbix.com/zabbix/3.0/rhel/5/x86_64/zabbix-agent-3.0.17-1.el5.x86_64.rpm || echo 'não é CentOS 5'; 
yum install zabbix zabbix-agent -y &&
cd /tmp/ &&
git clone https://github.com/Valdenirmezadri/zabbix &&
rsync -zuva zabbix/ /etc/zabbix/ &&
chmod +x /etc/zabbix/bin/* &&
mv /etc/zabbix/zabbix_agentd.conf.d /etc/zabbix/zabbix_agentd.d &&
read -p "Nome do Host: " host &&
sed -i "s/^Hostname=.*/Hostname=$host/g" /etc/zabbix/zabbix_agentd.conf &&
sed -i "s/^Server=.*/Server=177.37.95.190,186.209.30.113,177.54.11.234\/29/g" /etc/zabbix/zabbix_agentd.conf &&
sed -i "s/^#AllowRoot=.*/AllowRoot=1/g" /etc/zabbix/zabbix_agentd.conf &&
service zabbix-agent start &&
echo '0 */2 * * * root /etc/zabbix/bin/blacklist.sh | grep -v OK > /etc/zabbix/tmp/blacklist' >> /etc/crontab &&
mkdir /etc/zabbix/tmp &&
/etc/zabbix/bin/blacklist.sh | grep -v OK > /etc/zabbix/tmp/blacklist
