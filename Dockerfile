FROM ruby:3.2.0

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN gem install bundler && bundle install
COPY . /app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
