#!/bin/sh
SNAPSHOT_NUMBER=$1
DELAY_SECONDS=$2
DATA_DIRECTORY=$3
SNAPSHOT_DIRECTORY=$4
SNAPSHOT_FILENAME=$5
SNAPSHOT_FULL_PATH=$6

# Check to see if the snapshot directory exists
if [ ! -d "${SNAPSHOT_DIRECTORY}" ];
then
  echo "Creating directory: ${SNAPSHOT_DIRECTORY}"
  mkdir -p "${SNAPSHOT_DIRECTORY}"
fi

# send commands to SONY Camera
STOPREC=$(sh /home/pi/scripts/FDR-command.sh stopMovieRec) 
SHOOTMODE=$(sh /home/pi/scripts/FDR-command.sh "setShootMode" \"still\") 
PICTURE=$(sh /home/pi/scripts/FDR-command.sh "actTakePicture" | sed -e 's/.*\[\"\|\"\].*//g')

# copying PICTURE from camera

curl -o "${SNAPSHOT_FULL_PATH}" "${PICTURE}" > /dev/null 2>&1 

if [ ! -f "${SNAPSHOT_FULL_PATH}" ];
then
  echo "The snapshot was not found in the expected directory: '${SNAPSHOT_FULL_PATH}'." >&2 
  exit 1
fi
