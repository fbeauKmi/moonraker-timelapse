## Configure Script Camera for moonraker-timelapse ##

First you should connect your camera : 
- For DSLR you should follow the first part of [Octolapse guide](https://github.com/FormerLurker/octolapse/wiki/V0.4---Configuring-a-DSLR)
- For SONY Camera follow my quick guide [Configure_sony_camera](./Configure_sony_camera.md).

As I did not want to fork Mainsail too, the camera could not be set in UI settings, you should integrate those lines in `moonraker.conf`

```
## moonraker.conf

[timelapse]
camera_type: script #allow value webcam, script
camera: Your_Camera #whatever you want it is not used
snapshoturl: /home/pi/moonraker-timelapse/scripts/YOUR_SCRIPT.sh  #Path should be absolute
```

then restart moonraker.

You should be able to take a snapshot with `TIMELAPSE_TAKE_FRAME` from Mainsail console.
