export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export HADOOP_HOME=/vagrant/hadoop-2.9.1

# Unpack Hadoop 2.9.1
# http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-2.9.1/hadoop-2.9.1.tar.gz
if [ ! -d /vagrant/hadoop-2.9.1 ]; then
  wget -c http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-2.9.1/hadoop-2.9.1.tar.gz -P /vagrant
  tar -zxvf /vagrant/hadoop-2.9.1.tar.gz -C /vagrant
fi

# Hadoop configuration
sed -i "\$aexport JAVA_HOME=$JAVA_HOME" $HADOOP_HOME/etc/hadoop/hadoop-env.sh
sed -i "\$aexport HADOOP_HOME=/vagrant/hadoop-2.9.1" ~/.bashrc

# Create logs directory
if [ ! -d $HADOOP_HOME/logs ]; then
  mkdir $HADOOP_HOME/logs
fi

# Edit core-site.xml
CORE_SITE=$HADOOP_HOME/etc/hadoop/core-site.xml
mv $CORE_SITE $CORE_SITE.old
cat >$CORE_SITE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>fs.defaultFS</name>
<value>hdfs://0.0.0.0:9000</value>
</property>
<property>
<name>hadoop.tmp.dir</name>
<value>/home/vagrant/hadoop-\${user.name}</value>
</property>
</configuration>
EOL

# Edit hdfs-site.xml
HDFS_SITE=$HADOOP_HOME/etc/hadoop/hdfs-site.xml
mv $HDFS_SITE $HDFS_SITE.old
cat >$HDFS_SITE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>dfs.replication</name>
<value>1</value>
</property>
</configuration>
EOL

# Edit yarn-site.xml
YARN_SITE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
mv $YARN_SITE $YARN_SITE.old
cat >$YARN_SITE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
<property>
<name>yarn.resourcemanager.hostname</name>
<value>0.0.0.0</value>
</property>
<property>
<name>yarn.nodemanager.aux-services</name>
<value>mapreduce_shuffle</value>
</property>
</configuration>
EOL

# Edit mapred-site.xml
MAPRED_SITE=$HADOOP_HOME/etc/hadoop/mapred-site.xml
mv $MAPRED_SITE $MAPRED_SITE.old
cat >$MAPRED_SITE <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
<name>mapreduce.framework.name</name>
<value>yarn</value>
</property>
</configuration>
EOL

# Format HDFS on Namenode
echo 'Y' | $HADOOP_HOME/bin/hdfs namenode -format
