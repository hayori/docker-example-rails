FROM debian:jessie
MAINTAINER hayori

WORKDIR /app

RUN apt-get update && \
    apt-get install -y \
      build-essential \
      zlib1g-dev \
      libpq-dev \
      libxslt1-dev \
      libxml2-dev \
      libyaml-dev \
      sqlite3 \
      libsqlite3-dev \
      ruby2.1-dev \
      ruby=1:2.1.5+deb8u1 \
      nodejs=0.10.29~dfsg-2 && \
    rm -rf /var/lib/apt/lists/* && \
    gem install bundler --no-ri --no-rdoc

COPY Gemfile      /app/Gemfile
# COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install -j4

COPY . /app
# RUN bundle exec rake assets:precompile RAILS_ENV=production

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
