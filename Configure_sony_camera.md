# How to connect SONY camera to Raspi #

I own a Sony FDR-AX700, this quick guide is based on my experiment.

## Requirements ##

- You should be able to control your camera via your smartphone with [Sony Imaging Edge](https://imagingedge.sony.net)
[Sony remote API](https://developer.sony.com/develop/cameras/api-information/supported-devices/) is discontinued.
- Use SSH terminal of the Raspberry Pi
- You should use ethernet instead of wifi to control your printer

## First connect to Camera via WIFI ##

On the camera, start smartphone control and copy AP Name and password. They are generated automaticaly by the camera and do not change until you renew it.

On your Raspberry Pi edit `/boot/wpa_supplicant.txt`

```
network={
   ssid="DIRECT-AP_OF_YOUR_CAMERA"
   psk="WIFI_KEY"
}
```

After reboot, your Rasberry Pi is connected to the camera. 

Check your connection with

```
user@yourprinter:~ $ iwconfig wlan0
wlan0     IEEE 802.11  ESSID:"DIRECT-AP_OF_YOUR_CAMERA"
          Mode:Managed  Frequency:2.412 GHz  Access Point: 00:00:00:00:00:00
          Bit Rate:72.2 Mb/s   Tx-Power=31 dBm
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality=54/70  Signal level=-56 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0
```

## Preparing scripts ##

The camera is reachable via http. Most Sony cameras use as IP 192.168.122.1, if not can use [sony_camera_api](https://github.com/Bloodevil/sony_camera_api) to figure out what is you configuration

Below is the script I use to command the camera, it is working with FDR-AX700. You should probably adjust SONY_CAM for your own parameters. Check http://192.168.122.1:64321/DmsRmtDesc.xml from your Pi
and update it from `<av:X_ScalarWebAPI_ActionList_URL>` and `<av:X_ScalarWebAPI_ServiceType>`

```
## FDR-command.sh
#!/bin/sh
SONY_CAM="http://192.168.122.1:10000/sony/camera"
COMMAND=$1
PARAMS=$2
RESULT=$(curl $SONY_CAM -s -X POST -H "Content-type: application/json, charset=utf-8" -d  "{\"version\":\"1.0\",\"id\":1,\"method\":\"${COMMAND}\",\"params\":[${PARAMS}]}")
echo $RESULT

```

To get the capabilities of your camera, try in terminal `sh FDR-command.sh getAvailableApiList` the result is a JSON array of camera available commands.

```
{"id":1,"result":[["getAvailableApiList","setShootMode","getShootMode","getSupportedShootMode","getAvailableShootMode","getSupportedFlashMode","getSupportedSelfTimer","startLiveview","stopLiveview","actTakePicture","startMovieRec","stopMovieRec","awaitTakePicture","actZoom","setTouchAFPosition","cancelTouchAFPosition","getTouchAFPosition","setFNumber","getFNumber","getSupportedFNumber","getAvailableFNumber","actHalfPressShutter","cancelHalfPressShutter","getApplicationInfo","getEvent","getTemporarilyUnavailableApiList"]]}
```

## Example of snapshot script ##
This script is fully compatible with Octolapse script requirement. Some parameters are not used.

```
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
STOPREC=$(sh ./FDR-command.sh stopMovieRec) #assume that camera should 
SHOOTMODE=$(sh ./FDR-command.sh "setShootMode" \"still\")
PICTURE=$(sh ./FDR-command.sh "actTakePicture" | sed -e 's/.*\[\"\|\"\].*//g')

# copying PICTURE from camera
curl -o "${SNAPSHOT_FULL_PATH}" "${PICTURE}" > /dev/null 2>&1
if [ ! -f "${SNAPSHOT_FULL_PATH}" ];
then
  echo "The snapshot was not found in the expected directory: '${SNAPSHOT_FULL_PATH}'." >&2
  exit 1
fi

```
