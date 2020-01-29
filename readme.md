# ELK Stack -README

This README document will discuss how to import previously created kibana dashboard into new PC environment by installing ELK stack and manipulate servers.How to code queries using KQL and how to create dashboard will not be discuss by this document.
### 1.Clone the GIT repository
Clone the GIT repository 
```sh
git clone https://github.com/rehanja/ELK-stack-dashboard
```
### 2.Download ELK stack Open source version 
Download main ELK stack components(Elasticsearch, kibana ,logstash) using below links into the previously cloned directory.

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
./logstash-7.4.1/bin/logstash -f logstash.conf
```
If you complete all steps correct the dashboard should run real time.


### 8.Special notice
In almost all visualizations there is a filter called "subscription".It should filter the value that have "subscription"
in "ncs" colum(Documentation field 16 and logstash .conf file field 18). But due tho mistake in log simulator that field hasn't "subscription" string and it was in the "source-channel-type" colum(Documentation field 09 and logstash .conf file field 11). There for i have wrote all the queries relevant to  "source-channel-type" colum(Documentation field 09 and logstash .conf file field 11). There for when you deploy in the real system it should change to "ncs" colum(Documentation field 16 and logstash .conf file field 18) by doing below steps....

Run the 3 ELK servers and open the kibana UI in favourite browser

Go to the "Visualize" on the left side bar

Choose and click on Visualizations that have filter called "subscription" as a example "Registration count over last 30 days" visualization.

Click on "subscription" filter -> Edit filter -> Edit as Query DSL -> Replace "field11" with "field18" and save the filter also the visualization.

You need to change all visualization by above method except "App wise registration distribution". Because "App wise registration distribution" is a Timelion visualizationan it has a different queries.

To change "App wise registration distribution" visualization go to the "Visualize" on the left side bar Choose and click on Visualizations.

In the left side the query relevant to the visualization will display in the box called "Timelion Expression".

In that replace all "field11" with "field18" and save.



