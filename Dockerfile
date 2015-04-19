FROM ruby:2.2-onbuild

EXPOSE 16668

ENTRYPOINT ["bundle", "exec", "atig"]

CMD ["-d", "-h", "0.0.0.0"]
