FROM ruby:2.2

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

RUN apt-get update && apt-get install -y \
  nodejs \
  npm

RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g babel

# Expose port 4567 to the Docker host, so we can access it
# from the outside.
EXPOSE 4567

# The main command to run when the container starts. Also
# tell sinatra to bind to all interfaces by default.
CMD ["bundle", "exec", "./app.rb", "-o", "0.0.0.0"]
