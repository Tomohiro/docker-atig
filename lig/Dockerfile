FROM        ruby:2.2.2
MAINTAINER  Tomohiro TAIRA <tomohiro.t@gmail.com>

RUN         git clone https://github.com/psychs/lingr-irc.git /usr/src/app
WORKDIR     /usr/src/app

EXPOSE      26667
ENTRYPOINT  ["ruby", "lig.rb"]
CMD         [""]
