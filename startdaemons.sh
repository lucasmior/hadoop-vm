export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export HADOOP_HOME=/vagrant/hadoop-2.9.1

# Start NameNode and DataNode (HDFS) daemons
# sudo -u hdfs $HADOOP_HOME/sbin/hadoop-daemon.sh start namenode
# sudo -u hdfs $HADOOP_HOME/sbin/hadoop-daemon.sh start datanode
$HADOOP_HOME/sbin/hadoop-daemon.sh start namenode
$HADOOP_HOME/sbin/hadoop-daemon.sh start datanode

# Start ResourceManager and NodeManager (YARN) daemons
# sudo -u yarn $HADOOP_HOME/sbin/yarn-daemon.sh start resourcemanager
# sudo -u yarn $HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
$HADOOP_HOME/sbin/yarn-daemon.sh start resourcemanager
$HADOOP_HOME/sbin/yarn-daemon.sh start nodemanager
