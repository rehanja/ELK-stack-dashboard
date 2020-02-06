# ELK Stack -README

This README document will discuss how to import previously created kibana dashboard into new PC environment by installing ELK stack and manipulate servers.How to code queries using KQL and how to create dashboard will not be discuss by this document.

# Required software

Java(version according to your ELK stack version)

### 1.Clone the GIT repository
Clone the GIT repository 
```sh
git clone https://gitbd.hsenidmobile.com/hms/data-science/optin-anomaly
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

First Elasticsearch server should start then Logstash server and finally Kibana server.

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

### 5.Manipulate logstash 
#### Configurations
Copy and paste the `logstash.conf` file in to your logstash directory.
`logstash.conf` file can be found in git repository.

You must change the .conf log file input location in "input" section.There is a example below
```sh
input{
	file{
	    path => "/hms/logs/sdp-server/*"
...
```

**NOTE:** If you are feeding another type of logs you have to change the "filter" section according to your logs.

Run logstash server by
```sh
cd ./logstash-7.4.1/bin
./logstash -f ./../logstash.conf
```

### 6.kibana server manipulation

cd into elasticsearch bin folder
```sh
cd kibana-6.5.0-linux-x86_64/bin/
```
```sh
./kibana
```
Then kibana server will run in http://localhost:5601

### 7.Create a Index 
You have to create a index pattern to start Dashboard.For that go to

```sh
home page->Management->Index patterns->Create index pattern->[name of index pattern]
```

You have to give a name for index pattern that choose the index name in the logstash.conf file.
Eg: translog

If it's happen correctly "Success! Your index pattern matches 1 index." message will apper.Then 

```sh
->Next Step ->Time Filter field name->[Choose @timestamp]->Create index pattern
```

### 8.Import Kibana visualization dashboard
In GIT repository go to NotCompulsoryFile -> download exportDashboards.ndjson 

Open http://localhost:5601 and go to kibana Home page 
```sh
Management->Saved Objects->Import->[exportDashboards.ndjson]->Import->Done
```
Go to home page
```sh 
Dashboard->Test dashboard1
```
The dashboard that previously created should appear there but will not run till log file feed by logstash.



### 9.Special notice
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

### 10.Other file discription in the GIT repository
###### NotCompulsoryFile
There is a seperate README file inside this folder.
###### logstash.conf
The configuration file for the ELK stack logstash server. I have further discribe about this file under "5.Manipulate logstash".
###### report.sh 
Shell script for Daily report creation(Scheduled time 00:10) relevant to "Rapidly growing Apps" visualization.Open a terminal and run
```sh 
./report.sh
```
to execute this script. And the reports(In JSON file format) will create in the same directory where the report.sh located.
###### report2020_01_16__09_20_01.json
Example report which is created by using report.sh.



 
