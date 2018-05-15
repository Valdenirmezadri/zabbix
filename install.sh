yum install zabbix zabbix-agent -y &&
cd /tmp/ &&
git clone https://github.com/Valdenirmezadri/zabbix &&
rsync -zuva zabbix/ /etc/zabbix/ &&
chmod +x /etc/zabbix/bin/* &&
cp /etc/zabbix/sudoers.d/* /etc/sudoers.d/ &&
read -p "Nome do Host: " host &&
sed -i "s/^Hostname=.*/Hostname=$host/g" /etc/zabbix/zabbix_agentd.conf &&
sed -i "s/^Server=.*/Server=177.37.95.190,186.209.30.113,177.54.11.234\/29/g" /etc/zabbix/zabbix_agentd.conf &&
service zabbix-agent start
