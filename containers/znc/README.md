ZNC IRC bouncer for Docker
================================================================================

[![](https://badge.imagelayers.io/tomohiro/znc:latest.svg)](https://imagelayers.io/?images=tomohiro/znc:latest 'Get your own badge on imagelayers.io')


Getting Started
--------------------------------------------------------------------------------

Pull image from Docker Hub:

```sh
$ docker pull tomohiro/znc
```

Create configs:

```sh
$ docker run -it -v $HOME/.znc:/znc-data tomohiro/znc -r -c --datadir /znc-data
```

Start:

```sh
$ docker run -d --name znc -p 6669:6667 -v $HOME/.znc:/znc-data tomohiro/znc
```


Auto launching with Fleet
--------------------------------------------------------------------------------

Create `znc.service` like this:

```
[Unit]
Description=ZNC IRC bouncer
After=docker.service
Requires=docker.service

[Service]
Restart=always
TimeoutStartSec=120
ExecStartPre=-/usr/bin/docker kill znc
ExecStartPre=-/usr/bin/docker rm znc
ExecStartPre=/usr/bin/docker pull tomohiro/znc
ExecStart=/usr/bin/docker run --rm --name znc -p 6669:6667 -v /home/core/.znc:/znc-data tomohiro/znc
ExecStop=/usr/bin/docker stop znc

[X-Fleet]
Conflicts=znc.service
```

Add to Fleet unit-files:

```sh
$ fleetctl load znc.service
```

Launch `znc` unit:

```sh
$ fleetctl start znc
```
