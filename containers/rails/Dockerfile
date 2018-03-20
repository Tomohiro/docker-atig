# https://github.com/docker-library/ruby/blob/master/2.5/alpine3.7/Dockerfile
FROM         alpine:3.7
LABEL        maintainer="Tomohiro Taira <tomohiro.t@gmail.com>"

RUN          set -ex \
                \
                && apk --update --no-cache add build-base ruby ruby-dev ruby-nokogiri \
                && gem update --system --no-ri --no-rdoc \
                && gem install railties --no-ri --no-rdoc \
                && gem cleanup \
                && apk del --no-cache build-base ruby-dev

ENTRYPOINT   ["rails"]
CMD          ["--version"]
