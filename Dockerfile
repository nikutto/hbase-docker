FROM openjdk:11

RUN apt update && apt install -y \
    pdsh \
    openssh-server

WORKDIR /workspace

RUN wget https://dlcdn.apache.org/hbase/2.5.5/hbase-2.5.5-bin.tar.gz && \
    tar xvf hbase-2.5.5-bin.tar.gz && mv hbase-2.5.5 /usr/local/bin/. && \
    wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    tar xvf hadoop-3.3.6.tar.gz && mv hadoop-3.3.6 /usr/local/bin/. && \
    echo 'export PATH=$PATH:/usr/local/bin/hbase-2.5.5/bin' >> ~/.bashrc && \
    echo 'export PATH=$PATH:/usr/local/bin/hadoop-3.3.6/bin' >> ~/.bashrc

COPY ./etc/hadoop/core-site.xml ./etc/hadoop/hdfs-site.xml /usr/local/bin/hadoop-3.3.6/etc/hadoop/
COPY ./etc/hbase/hbase-site.xml /usr/local/bin/hbase-2.5.5/conf

WORKDIR /

RUN rm -rf /workspace

# NAMENODE WebUI
EXPOSE 9870
# YARN WebUI
EXPOSE 8088

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
