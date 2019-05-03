FROM node:10.15.3 as node
FROM ruby:2.5.1
MAINTAINER undrthemt@gmail.com

RUN apt-get update -qq && apt-get install -y postgresql-client && \
    apt-get install -y locales

# node を image から使えるようにする
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

RUN mkdir -p /var/www/web
WORKDIR /var/www/web

# Add a script to be executed every time the container starts.
COPY ./entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN locale-gen ja_JP.UTF-8
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
EXPOSE 3000
