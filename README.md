# docker-example-rails

## プロジェクト作成

```
mkdir hogehoge; cd hogehoge
cp -r ../docker-example-rails/* .
/bin/sh dotinit.sh
cd coreos
vagrant up
vagrant ssh
```

### coreos内作業

```
cd hogehoge
docker-compose build
docker-compose run --rm web rails new .
```

Gemfile に以下を追加
```ruby
# Use Puma as the app server
gem 'puma'

# Use rails_stgout_logging to configure your app to log to standard out
gem 'rails_stdout_logging'
```

Dockerfile の以下のコメントを解除

```
# COPY Gemfile.lock /app/Gemfile.lock

# RUN bundle exec rake assets:precompile
```

再ビルド
```
docker-compose build
docker-compose up -d db     # Postgresqlの場合
docker-compose run --rm web rake db:create db:migrate
docker-compose up
```

## Postgresqlの場合

プロジェクト新規作成の指定を以下に変更
```
docker-compose run --rm web rails new . -d postgresql
```

config/database.yml を以下のように記述

```ruby
default: &default
  adapter: postgresql
  database: hogehoge
  encoding: unicode
  username: <%= ENV['DATABASE_USER'] %>
  password: <%= ENV['DATABASE_PASSWORD'] %>
  host:     <%= ENV['DATABASE_HOST'] %>
  port:     <%= ENV['DATABASE_PORT'] %>

development:
  <<: *default
  database: hogehoge_development

test:
  <<: *default
  database: hogehoge_test

production:
  <<: *default
  database: hogehoge_production
```

## 動作テスト

```
docker-compose run --rm web rails g scaffold blog title
docker-compose run --rm web rake db:migrate
docker-compose up
```
