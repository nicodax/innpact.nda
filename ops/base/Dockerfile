FROM ghcr.io/belighted/docker-ruby-jemalloc/ruby-jemalloc:3.1.3

LABEL maintainer="Dominique Lebrun <dominique.lebrun@belighted.com>"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV BUNDLE_IGNORE_CONFIG 1
ENV BUNDLE_WITHOUT test:production:development

RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qqy --no-install-recommends \
    nodejs \
    xfonts-75dpi \
    xfonts-base \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && truncate -s 0 /var/log/*log

RUN wget http://www.freetds.org/files/stable/freetds-1.1.24.tar.gz \
    && tar -xzf freetds-1.1.24.tar.gz \
    && cd freetds-1.1.24 \
    && ./configure --prefix=/usr/local --with-tdsver=7.3 \
    && make \
    && make install

EXPOSE 3000
WORKDIR /app

RUN gem update bundler

COPY Gemfile* /app/
RUN bundle install

RUN npm install yarn -g
RUN yarn install
