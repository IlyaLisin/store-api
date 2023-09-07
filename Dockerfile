FROM ruby:3.2.2

ENV WD=/app/
WORKDIR $WD

RUN apt update && \
    gem install bundler && \
    apt-get install -y postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD . $WD

RUN bundle install --retry=3 --jobs 4

EXPOSE 3000
