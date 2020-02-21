FROM ruby:2.7-alpine
RUN gem install gmail-britta
ENTRYPOINT ["/usr/local/bin/ruby"]
