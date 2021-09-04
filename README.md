# E3C-Control
Alpine docker image of https://github.com/Eba-M/E3DC-Control

This docker container runs the [e3dc-control](https://github.com/Eba-M/E3DC-Control) of [Eba-M](https://github.com/Eba-M).
E3DC-Control is an optimized battery loading and wallbox using algorithm, to optimize self consumption of the solar power, to slow the rate of battery aging and prevent [german] "Abregelung" (restriction of power feed into the grid). This is optimized alternative than the E3DC owned algorithm.

It is necessary to 
 - configure RSCP access on the E3DC (take a look to your E3DC manual) and 
 - also configure E3DC-Control ([Parameter description 1](https://github.com/Eba-M/E3DC-Control/blob/master/Beschreibung_Parameter)/[Parameter description 2](https://forum.iobroker.net/topic/32976/e3dc-hauskraftwerk-steuern/2) and [minimum example](https://github.com/Eba-M/E3DC-Control/blob/master/e3dc.config.txt.template))

## See also
https://www.photovoltaikforum.com/thread/125497-e3dc-%C3%BCberschusssteuerung-per-rscp-und-raspberry-pi/

Screen is used to run E3DC-Control in the background. Also checks every 10 seconds if screen exists otherwise restart screen.

The architectures supported by this image are:

| Architecture | Tag | 
| ------ | ------ |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |

## Usage

docker image: https://hub.docker.com/r/chriskuba/e3dc-control

### docker-compose
```
---
version: "0.0.1"
service:
  e3dc-control:
    image: chriskuba/e3dc-control
    container-name: dynv6-client
    volumes:
      - /path/to/config:/config
      - /path/to/savedtoday.txt:/home/service_user/savedtoday.txt #optional
      - /path/to/logs:/your/configured/logpath/in/e3dc.config.txt #optional
    restart: always
```

### docker-cli
```
docker run -d \
  --name=dynv6-client \  
  -v /path/to/config:/config \
  -v /path/to/savedtoday.txt:/home/service_user/savedtoday.txt #optional
  -v /path/to/logs:/your/configured/logpath/in/e3dc.config.txt #optional
  --restart always
  chriskuba/e3dc-control
```

### Parameters
| Parameter | Function |
| ------ | ------ |
| -v /config | Contains the e3dc.config.txt. |
| -v /home/service_user/savedtoday.txt | If file should be saved, mapping is necessary. |
| -v /your/configured/logpath/in/e3dc.config.txt | When configured logs, this must be defined, except the log folder exists within /config. |

### THX to
https://hub.docker.com/r/stehada/e3dc-control

## Known Issues
The alpine docker image is fix to the last 1.12 version because of a dns resolving bug in newer version.
https://github.com/alpinelinux/docker-alpine/issues/155
https://github.com/nginxinc/docker-nginx/issues/508