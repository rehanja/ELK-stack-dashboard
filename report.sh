#! /bin/bash
#Shell script for Daily report creation(Time 00:10) relevant to "Rapidly growing Apps" visualization.Open a terminal and #run
 
#"./report.sh"
#to run this script. And the reports(In JSON file format) will create in the same directory where the report.sh located.

RUNAT="00:10"

while [ 1 ]
do
	DATE=`/bin/date +%H:%M`

	NAME_CONSTANT="report"
	NAME_VARIABLE=`date '+%Y_%m_%d__%H_%M_%S'`;

	name="$NAME_CONSTANT""$NAME_VARIABLE"

	if [ $DATE. = $RUNAT. ]
    	then
    	echo $name
    
		curl -XGET "http://localhost:9200/translog/_search" -H 'Content-Type: application/json' -d'{  "aggs": {    "2": {      "terms": {        "field": "field7.keyword",        "order": {          "_key": "asc"        },        "size": 50      },      "aggs": {        "3": {          "date_range": {            "field": "@timestamp",            "ranges": [              {                "from": "now-29d/d",                "to": "now-0d/d"              },              {                "from": "now-29d/d",                "to": "now-22d/d"              },              {                "from": "now-22d/d",                "to": "now-15d/d"              },              {                "from": "now-15d/d",                "to": "now-8d/d"              },              {                "from": "now-8d/d",                "to": "now-1d/d"              },              {                "from": "now-1d/d",                "to": "now-0d/d"              }            ],            "time_zone": "Asia/Colombo"          }        }      }    }  },  "size": 0,  "_source": {    "excludes": []  },  "stored_fields": [    "*"  ],  "script_fields": {    "weekDays": {      "script": {        "source": "[\"\", \"1-Monday\", \"2-Tuesday\", \"3-Wednesday\", \"4-Thursday\", \"5-Friday\", \"6-Saturday\", \"7-Sunday\"][doc[\"@timestamp\"].value.dayOfWeek]",        "lang": "painless"      }    },    "monthDates": {      "script": {        "source": "[ \"\",\"01\", \"02\", \"03\", \"04\", \"05\", \"06\", \"07\", \"08\", \"09\", \"10\", \"11\", \"12\", \"13\", \"14\", \"15\", \"16\", \"17\", \"18\", \"19\", \"20\", \"21\", \"22\", \"23\", \"24\", \"25\", \"26\", \"27\", \"28\", \"29\", \"30\", \"31\"][doc[\"@timestamp\"].value.dayOfMonth]",        "lang": "painless"      }    },    "dayHours": {      "script": {        "source": "[\"00\", \"01\", \"02\", \"03\", \"04\", \"05\", \"06\", \"07\", \"08\", \"09\", \"10\", \"11\", \"12\", \"13\", \"14\", \"15\", \"16\", \"17\", \"18\", \"19\", \"20\", \"21\", \"22\", \"23\"][doc[\"@timestamp\"].value.hourOfDay]",        "lang": "painless"      }    }  },  "docvalue_fields": [    {      "field": "@timestamp",      "format": "date_time"    }  ],  "query": {    "bool": {      "must": [],      "filter": [        {          "match_all": {}        },        {          "match_all": {}        },        {          "bool": {            "should": [              {                "match_phrase": {                  "field31": "registrationCharging "                }              },              {                "match_phrase": {                  "field31": "freeRegistration"                }              }            ],            "minimum_should_match": 1          }        },        {          "match_phrase": {            "field32": {              "query": "S1000"            }          }        },        {          "range": {            "@timestamp": {              "format": "strict_date_optional_time",            "gte": "now+1m-1M/M",               "lt": "now/M"            }          }        }      ],      "should": [],      "must_not": []    }  }}' -o $name.json
    fi
    sleep 60

done

