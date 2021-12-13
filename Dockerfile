FROM ruby:2.7.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn npm

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install
ADD . /app

RUN npm install --global yarn
RUN bundle exec rails webpacker:install