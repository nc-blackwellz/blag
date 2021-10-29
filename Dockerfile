FROM ruby:2.7

#Register
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add =
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update -qq
RUN apt install -y postgresql-client nodejs yarn

WORKDIR /ror
COPY ./ror /ror
RUN gem install bundler
RUN bundle install

COPY ./.docker/ror/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]\
# CMD ["/bin/bash"]