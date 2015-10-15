from ubuntu:wily

MAINTAINER JCHUGH

RUN apt-get update
RUN apt-get install -y software-properties-common python libnss3 sudo

# JAVA 8
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer maven


ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV SPARK_VERSION 1.5.1
ENV SCALA_VERSION 2.11.7
ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME:$PATH
ENV SCALA_HOME /Library/Scala/scala-$SCALA_VERSION

ENV SPARK_MASTER_PORT 7077
ENV SPARK_WORKER_PORT 7088

# Create Directories
RUN mkdir /opt/spark


# Download Everything we need
ADD http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb /
RUN wget https://www.googledrive.com/host/0Bw4Hdv5THI68UzdSX1d4ZVJhTUk -O spark-$SPARK_VERSION_$SCALA_VERSION.tgz /


# Install Scala
RUN sudo dpkg -i scala-$SCALA_VERSION.deb

# Install Spark
RUN tar -xzf spark-$SPARK_VERSION_$SCALA_VERSION.tgz -C /opt/spark --strip-components=1
ADD conf/spark-defaults.conf /opt/spark/conf/

# Remove the downloads
RUN rm scala-2.11.7.deb spark-1.5.1_2.11.tgz

EXPOSE 4040 18080 7001 7002 7003 7004 7005 7006 8080 8081 7077 7088





