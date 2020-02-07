# ELK Stack -README

This README document will have a discription about how to manipulate files in "NotCompulsoryFile" folder.

### 1.DevTools.txt
This file contain the code that should run in kibana "Dev Tools" terminal to generate "Rapidly growing apps for registration" visualization data for a month in JSON format. 
To execute this file go to
```sh
Kibana home page-> Dev Tools -> [Copy the code in to 'Console'] -> execute
```
This file output will show in the right hand side terminal. "report.sh" file has created by coping this console code as a cURL command.

### 2.exportDashboards.ndjson
This is the file that has two dashboards and related visualization.I have further discribe about this file under "8.Import Kibana visualization dashboard" in "readme.md" in main GIT repository.

### 3.LogCreation.sh

This bash script can use to create 12 seperate hours timestamp log files in same day.You need to change output file name and time according to your requirement.To execute this script open a terminal and 
```sh
./LogCreation.sh
```
### 4.ELK_stack_HLD

High level diagram for ELK stack.
