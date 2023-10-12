#!/bin/bash -ex
java -version
sudo yum -y install java-1.8.0-openjdk
sudo yum -y remove java-1.7.0-openjdk
java -version

sudo su
yum install -y
cd /root
wget  https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.noarch.rpm
yum install elasticsearch-1.7.2.noarch.rpm -y
rm -f elasticsearch-1.7.2.noarch.rpm

service elasticsearch start

sudo chkconfig --add elasticsearch

echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
cd /usr/share/elasticsearch/
./bin/plugin -install mobz/elasticsearch-head
./bin/plugin -install lukas-vlcek/bigdesk
./bin/plugin --install lmenezes/elasticsearch-kopf/1.5.7

sudo su
yum update -y
cd /root
wget https://download.elastic.co/kibana/kibana/kibana-4.1.2-linux-x64.tar.gz
tar xzf kibana-4.1.2-linux-x64.tar.gz
rm -f kibana-4.1.2-linux-x64.tar.gz
cd kibana-4.1.2-linux-x64
nano config/kibana.yml
nohup ./bin/kibana &
