#!/bin/sh
SONY_CAM="http://192.168.122.1:10000/sony/camera"
COMMAND=$1
PARAMS=$2
RESULT=$(curl $SONY_CAM -s -X POST -H "Content-type: application/json, charset=utf-8" -d  "{\"version\":\"1.0\",\"id\":1,\"method\":\"${COMMAND}\",\"params\":[${PARAMS}]}")
echo $RESULT
