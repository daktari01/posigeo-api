FROM ruby:3.3.1-alpine

RUN apk add --no-cache \
    build-base \
    postgresql-client \
    git \
    tzdata \
    bash

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY . .

RUN bundle exec rails assets:precompile || true

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
