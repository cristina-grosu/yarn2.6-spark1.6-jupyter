# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export JAVA_HOME=/opt/jdk1.8.0_72
export JRE_HOME=/opt/jdk1.8.0_72/jre
export PATH=$PATH:/opt/jdk1.8.0_72/bin:/opt/jdk1.8.0_72/jre/bin
export HADOOP_HOME=/opt/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_CLASSPATH=$PATH
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"
export HADOOP_OPTS="$HADOOP_OPTS -XX:-PrintWarnings -Djava.net.preferIPv4Stack=true"
