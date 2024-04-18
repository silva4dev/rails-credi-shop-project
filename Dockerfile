FROM ruby:3.3.0

ENV BUNDLER_VERSION='2.3.7'
ENV APP_USER=user

RUN apt-get update -qq && apt-get install -y \
        vim \
        curl \
        build-essential \
        libpq-dev \
        postgresql-client \
        dirmngr \
        apt-transport-https \
        lsb-release \
        redis-tools \
        redis-server

RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash -
RUN apt-get install -y nodejs

RUN useradd -ms /bin/bash $APP_USER

WORKDIR /app

RUN chown -R $APP_USER:$APP_USER /app

USER $APP_USER

COPY --chown=$APP_USER Gemfile Gemfile.lock ./
COPY --chown=$APP_USER pnpm-lock.yaml package.json ./

RUN rm -rf $APP_USER/tmp/* \
  && rm -rf public/assets \
  && rm -rf public/packs

RUN gem install bundler -v $BUNDLER_VERSION

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install

COPY --chown=$APP_USER . ./

RUN chmod +x entrypoints/docker-entrypoint.sh

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
