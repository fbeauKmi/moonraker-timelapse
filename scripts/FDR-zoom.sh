#!/bin/sh
START=$(sh ./FDR-command.sh actZoom \"$1\",\"start\")
sleep $2
STOP=$(sh ./FDR-command.sh actZoom \"$1\",\"stop\")
