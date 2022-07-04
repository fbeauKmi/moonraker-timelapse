#!bin/sh
SONY_CAM="http://192.168.122.1:10000/sony/camera";
HEADER="application/json, charset=utf-8";

PICTURE=$(curl -s $SONY_CAM -X POST -H "${HEADER}" --max-time 1 -d '{"id":2, "method":"stopMovieRec","params":[],"version":"1.0"}')

