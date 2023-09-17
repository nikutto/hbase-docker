#!/bin/sh

## Setup SSH

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

mkdir /run/sshd
/usr/sbin/sshd -D &

## Launch HDFS

cd /usr/local/bin/hadoop-3.3.6

echo 'export JAVA_HOME=/usr/local/openjdk-11' >> ./etc/hadoop/hadoop-env.sh
echo 'export PDSH_RCMD_TYPE=ssh' >> ./etc/hadoop/hadoop-env.sh

export HDFS_NAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export HDFS_SECONDARYNAMENODE_USER="root"

./bin/hdfs namenode -format
./sbin/start-dfs.sh

## Launch YARN

export YARN_RESOURCEMANAGER_USER="root"
export YARN_NODEMANAGER_USER="root"
./sbin/start-yarn.sh

## Launch HBase

cd /usr/local/bin/hbase-2.5.5

echo 'export JAVA_HOME=/usr/local/openjdk-11' >> ./conf/hbase-env.sh
ssh 127.0.0.1 -o "StrictHostKeyChecking=no" -t 'echo "Trust SSH"'

./bin/start-hbase.sh

## Sleep

cd /

echo 'Run JPS to check HBase running correctly.'
jps

echo '##############################'
echo '## HBase has been Launched. ##'
echo '##############################'
sleep infinity
