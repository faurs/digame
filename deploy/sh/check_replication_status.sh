#!/bin/bash
#
# Set the maximum number of seconds behind master that will be ignored. 
# If the slave is be more than maximumSecondsBehind, an email will be sent. 
#
dbAccount='root'
dbPasswd='woer.net'

maximumSecondsBehind=300

#
# Checking MySQL replication status...
#
mysql -u $dbAccount -p$dbPasswd -e 'SHOW SLAVE STATUS \G' | grep 'Running:\|Master:\|Error:' > replicationStatus.txt


#
# displaying results, just in case you want to see them 
#
echo "Results:"
cat replicationStatus.txt


#
# checking parameters
#
slaveRunning="$(cat replicationStatus.txt | grep "Slave_IO_Running: Yes" | wc -l)"
slaveSQLRunning="$(cat replicationStatus.txt | grep "Slave_SQL_Running: Yes" | wc -l)"
secondsBehind="$(cat replicationStatus.txt | grep "Seconds_Behind_Master" | tr -dc '0-9')"


#
# Sending email if needed
#
if [[ $slaveRunning != 1 || $slaveSQLRunning != 1 || $secondsBehind -gt $maximumSecondsBehind ]]; then
  echo ""
  echo "Replication error"
else
  echo ""
  echo "Replication looks fine."
fi
