FROM ruby:3.1.2

WORKDIR /app

RUN apt-get update && apt-get install -y && gem install bundler && apt-get install postgresql-client -y

COPY Gemfile* .

RUN  bundle install --gemfile Gemfile

COPY . .

CMD ["./init_script.sh"]