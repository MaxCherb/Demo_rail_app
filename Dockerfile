# stage builder
FROM ruby:3.1.2 as builder

WORKDIR /app

RUN apt-get update && apt-get install -y && gem install bundler && apt-get install postgresql-client -y

COPY Gemfile* .

RUN  bundle install --gemfile Gemfile

COPY . .


# stage runner
FROM ruby:3.1.2-slim-bullseye AS runner
WORKDIR /app

RUN apt-get update && \
    apt-get install -y \
    libpq-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . .

EXPOSE 3000
RUN chmod +x init_script.sh
CMD ["./init_script.sh"]