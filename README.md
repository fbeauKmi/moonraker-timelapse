# Moonraker-timelapse Script mod

A 3rd party Moonraker component to create timelapse of 3D prints.
Here is fork of moonraker timelapse : First attempt to get it work with sh script base camera

Learn More about...   
https://github.com/mainsail-crew/moonraker-timelapse

## Experimental : simulate toolhead motion ##
macro TIMELAPSE_MOTION_SETTINGS allows to give 'motion' to the toolhead.

To give motion, the following paramters must be set:
MOTION_MODE = none(default), linear (go and back between 2 points), ellipse (draw an ellipse in 2 points area), star (draw a star), orbital, flower
MOTION_SPEED = number of frames for full motion
X1, Y1 and X2, Y2 = coords of the motion area 

MOTION_MODE works only if PARK_POS is set to ``custom``

> **CAUTION : Use this at your own risk. As the plugin allows to run shell command on the server you may expose your printer to security issues. Be sure to understand your shell script behavior.**

[![IMAGE ALT TEXT](http://img.youtube.com/vi/SUKD1InMwU8/0.jpg)](https://youtube.com/watch?v=SUKD1InMwU8 "First TimeLapse")

## Small history of this project ##

I recently build a [VORON 2.4](https://www.vorondesign.com/voron2.4)  and switch my main printer from Marlin/Octoprint to klipper/mainsail. Octoprint offers many plugins, huge community, ... whatever. I used to make timelapses with a SONY FDR-AX700 camera with Octolapse, to get stabilization, and easy support for DSLR cameras.

SONY FDR-AX700 is not a DSLR and is controlled via WIFI AP of the camera 

## What a script based camera ? ## 

As Octolapse do, this component use shell script to control DSLR and other cameras. More information [here](https://github.com/FormerLurker/octolapse/wiki/V0.4---Configuring-a-DSLR#step-6---configure-octolaps)

## Configure Camera for moonraker-timelapse ##

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

