FROM ghcr.io/belighted/innpact.base:latest
LABEL maintainer="Dominique Lebrun <dominique.lebrun@belighted.com>"
ENV BUNDLE_WITHOUT development:production
ENV BUNDLE_WITH test
ENV RAILS_ENV test

RUN npm install yarn -g

COPY Gemfile* /app/
RUN bundle install

CMD bundle exec rspec
