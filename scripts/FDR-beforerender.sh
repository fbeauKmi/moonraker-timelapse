#!bin/sh
SONY_CAM="http://192.168.122.1:10000/sony/camera";
HEADER="application/json, charset=utf-8";

SHOOTMODE=$(curl -s $SONY_CAM -X POST -H "${HEADER}" --max-time 2 -d '{"id":1,"method":"setShootMode","params":["movie"],"version":"1.0"}')>/dev/null 
PICTURE=$(curl -s $SONY_CAM -X POST -H "${HEADER}" --max-time 1 -d '{"id":2, "method":"startMovieRec","params":[],"version":"1.0"}')

