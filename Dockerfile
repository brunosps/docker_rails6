FROM ruby:2.6-alpine

RUN apk update && apk add build-base postgresql-dev
RUN apk add --update nodejs nodejs-npm

RUN mkdir /app
WORKDIR /app

RUN node -v
RUN npm -v

RUN gem install bundler -v 2.0.1
RUN gem install foreman 

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

RUN npm install -g yarn
RUN yarn install --check-files

COPY . .

LABEL maintainer="Bruno Santos <brunosps00@gmail.com>"

CMD puma -C config/puma.rb
