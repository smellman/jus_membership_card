FROM ruby:2.7.1

WORKDIR /usr/app/src

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY JUS.png .
COPY ipaexm.ttf .
COPY mplus-2c-heavy.ttf .
COPY mplus-2c-medium.ttf .
COPY membership_card.rb .

ENV LANG C.UTF-8

ENTRYPOINT ["/usr/app/src/membership_card.rb"]