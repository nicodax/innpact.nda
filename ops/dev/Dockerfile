FROM ghcr.io/belighted/innpact.base:latest
LABEL maintainer="Dominique Lebrun <dominique.lebrun@belighted.com>"
ENV BUNDLE_WITHOUT test:production
ENV BUNDLE_WITH development
ENV RAILS_ENV development

COPY Gemfile* /app/
COPY package.json /app/
RUN bundle install
RUN yarn install

CMD yarn install && rm -f /app/tmp/pids/server.pid && rails s -b 0.0.0.0
