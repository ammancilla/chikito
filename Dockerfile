FROM ruby:2.7-slim

RUN apt-get update && apt-get install -y build-essential libpq-dev postgresql-client vim

RUN mkdir -p /home/chikito

WORKDIR /home/chikito

COPY Gemfile* ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD bundle exec rails s -b 0.0.0.0
