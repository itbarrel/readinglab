FROM ruby:3.1.0-alpine AS assets
LABEL maintainer="Saad Mahmood <saaadii7@gmail.com>"

WORKDIR /app

ARG UID=1000
ARG GID=1000

RUN apk --no-cache add \
    build-base \
    nodejs \
    yarn \
    tzdata \
    imagemagick \
    git \
    postgresql-dev \
    libxml2-dev \
    libxslt-dev \
    gcompat

RUN adduser -D -u $UID -g $GID ruby
RUN chown -R ruby /app
USER ruby

COPY --chown=ruby:ruby Gemfile* ./
RUN bundle config set --local without test development \
    # && bundle lock --add-platform x86_64-linux \
    && bundle install --jobs $(nproc) --retry 3 \
    && bundle clean --force

COPY --chown=ruby:ruby package.json *yarn* ./
RUN yarn install --frozen-lockfile --silent --no-progress && yarn cache clean

ARG RAILS_ENV="production"
ARG NODE_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    NODE_ENV="${NODE_ENV}" \
    USER="ruby"

COPY --chown=ruby:ruby . .
RUN SECRET_KEY_BASE=$(rails secret) RAILS_ENV=production bundle exec rake assets:precompile

############################################################################################

FROM ruby:3.1.0-alpine

WORKDIR /app

ARG UID=1000
ARG GID=1000

RUN apk --no-cache add \
    nodejs \
    tzdata \
    imagemagick \
    postgresql-dev \
    libxml2-dev \
    libxslt-dev \
    gcompat

RUN adduser -D -u $UID -g $GID ruby
RUN chown -R ruby /app
USER ruby

COPY --chown=ruby:ruby bin/ ./bin
RUN chmod 0755 bin/*

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin" \
    USER="ruby"

COPY --chown=ruby:ruby --from=assets /usr/local/bundle/ /usr/local/bundle/
COPY --chown=ruby:ruby --from=assets /app/public /app/public
COPY --chown=ruby:ruby . .
RUN mkdir -p /app/log && chown -R ruby:ruby /app/log
RUN mkdir -p /app/storage && chown -R ruby:ruby /app/storage
RUN mkdir -p /app/tmp && chown -R ruby:ruby /app/tmp

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
