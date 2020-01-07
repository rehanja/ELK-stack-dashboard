#! /bin/bash
#Daily report creation shell script(Time 00:10) for "Rapidly growing Apps" visualization in JSON format

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
    
		curl -XGET "http://localhost:9200/translog/_search" -H 'Content-Type: application/json' -d'{  "aggs": {    "2": {      "terms": {        "field": "field7.keyword",        "order": {          "_key": "asc"        },        "size": 50      },      "aggs": {        "3": {          "date_range": {            "field": "@timestamp",            "ranges": [              {                "from": "now-29d/d",                "to": "now-22d/d"              },              {                "from": "now-22d/d",                "to": "now-15d/d"              },              {                "from": "now-15d/d",                "to": "now-8d/d"              },              {                "from": "now-8d/d",                "to": "now-1d/d"              },              {                "from": "now-1d/d",                "to": "now-0d/d"              }            ],            "time_zone": "Asia/Colombo"          }        }      }    }  },  "size": 0,  "_source": {    "excludes": []  },  "stored_fields": [    "*"  ],  "script_fields": {},  "docvalue_fields": [    {      "field": "@timestamp",      "format": "date_time"    }  ],  "query": {    "bool": {      "must": [],      "filter": [        {          "match_all": {}        },        {          "match_all": {}        },        {          "match_phrase": {            "field31": {              "query": "registrationCharging"            }          }        },        {          "match_phrase": {            "field32": {              "query": "S1000"            }          }        },        {          "range": {            "@timestamp": {              "format": "strict_date_optional_time",              "gte": "now+1m-1M/M",              "lt": "now/M"            }          }        }      ],      "should": [],      "must_not": []    }  }}' -o $name.json
    fi
    sleep 60

done

