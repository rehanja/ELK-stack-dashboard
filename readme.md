# ELK Stack -README

This README document will discuss how to import previously created kibana dashboard into new PC environment by installing ELK stack and manipulate servers.How to code queries using KQL and how to create dashboard will not be discuss by this document.
### 1.Clone the GIT repository
Clone the GIT repository 
```sh
git clone https://github.com/rehanja/ELK-stack-dashboard
```
### 2.Download ELK stack Open source version 
Download main ELK stack components(Elasticsearch, kibana ,logstash) using below links into the previously cloned folder.

Elasticsearch-7.4.0 Open source version

https://www.elastic.co/downloads/elasticsearch or https://www.elastic.co/downloads/elasticsearch-oss

Kibana-7.4.1-linux-x86_64 Open source version

https://www.elastic.co/downloads/kibana-oss

Logstash-7.4.1 Open source version

https://www.elastic.co/downloads/logstash-oss

### 3.Extract above files into same directory
```sh
tar -zxvf [tar file name]
```
### 4.Elasticsearch server manipulation

cd into elasticsearch bin folder
```sh
cd elasticsearch-7.4.0/bin/
```
Start the server by
```sh
elasticsearch
```
Then elasticsearch server will run in http://localhost:9200 

If you want to stop server 
```sh
sudo kill -9 `sudo lsof -t -i:9200`
```
Because it will not stop till process kill in relevant port
### 5.kibana server manipulation
cd into kibana bin folder and start the server by
```sh
./kibana
```
Then kibana server will run in http://localhost:5601
### 6.Import Kibana visualization dashboard

Open http://localhost:5601 and go to kibana Home page 
```sh
Management->Saved Objects->Import->[Choose .ndjson file]->Import->Done
```
Go to home page
```sh 
Dashboard->Test dashboard 
```
The dashboard that previously created should appear there but will not run till log file feed by logstash.
### 7.Manipulate logstash 

Go to ELK stack folder(not logstash bin location) and copy/paste  the test.conf file


Open .conf file and change the "index" only if it's different to dashboard index.Should change the input log file path to relevant local machine location by changing “path”.

Run logstash server by
```sh
./logstash-7.4.1/bin/logstash -f test.conf
```
If you complete all steps correct the dashboard should run real time.

