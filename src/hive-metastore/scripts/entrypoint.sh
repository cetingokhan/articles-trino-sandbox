#!/bin/sh

export HADOOP_HOME=/opt/hadoop-3.3.6
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.12.367.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.3.6.jar
export JAVA_HOME=/usr/local/openjdk-8
export METASTORE_DB_HOSTNAME=${METASTORE_DB_HOSTNAME:-localhost}

MYSQL='mysql'
POSTGRES='postgres'

if [ "${METASTORE_TYPE}" = "${MYSQL}" ]; then
  echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 3306 ..."
  while ! nc -z ${METASTORE_DB_HOSTNAME} 3306; do
    sleep 1
  done

  echo "Database on ${METASTORE_DB_HOSTNAME}:3306 started"
  # Check if schema exists
  /opt/apache-hive-metastore-3.0.0-bin/bin/schematool -dbType mysql -info --verbose

  

  if [ $? -eq 0 ]; then    
    /opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
  else
    echo "Getting schema info failed. Probably not initialized. Initializing..."
    echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:3306"
    /opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType mysql --verbose    
    /opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
  fi

fi

if [ "${METASTORE_TYPE}" = "${POSTGRES}" ]; then
  echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 5432 ..."
  while ! nc -z ${METASTORE_DB_HOSTNAME} 5432; do
    sleep 1
  done

  echo "Database on ${METASTORE_DB_HOSTNAME}:5432 started"
  # Check if schema exists
  /opt/apache-hive-metastore-3.0.0-bin/bin/schematool -dbType postgres -info --verbose

  

  if [ $? -eq 0 ]; then    
    /opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
  else
    echo "Getting schema info failed. Probably not initialized. Initializing..."
    echo "Init apache hive metastore on ${METASTORE_DB_HOSTNAME}:5432"
    /opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType postgres --verbose    
    /opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
  fi
  

fi