export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
export HADOOP_HOME=/vagrant/hadoop-2.9.1

# Configure HDFS directories
USER=vagrant
# sudo -u hdfs $HADOOP_HOME/bin/hadoop fs -mkdir -p /user/$USER
# sudo -u hdfs $HADOOP_HOME/bin/hadoop fs -chown $USER:$USER /user/$USER
# sudo -u hdfs $HADOOP_HOME/bin/hadoop fs -mkdir /tmp
# sudo -u hdfs $HADOOP_HOME/bin/hadoop fs -chmod 777 /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir -p /user/$USER
$HADOOP_HOME/bin/hadoop fs -chown $USER:$USER /user/$USER
$HADOOP_HOME/bin/hadoop fs -mkdir /tmp
$HADOOP_HOME/bin/hadoop fs -chmod 777 /tmp
