FROM        buildpack-deps:stretch
MAINTAINER  Tomohiro TAIRA <tomohiro.t@gmail.com>

RUN         apt-get update
RUN         apt-get upgrade -y
RUN         apt-get install -y znc
RUN         apt-get autoremove -y
RUN         apt-get clean

EXPOSE      6667
ENTRYPOINT  ["znc"]
CMD         ["--allow-root", "--foreground", "--datadir", "/znc-data"]
