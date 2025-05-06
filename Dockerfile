FROM ruby:3.3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client imagemagick

# Set working directory
WORKDIR /myapp

# Install gems
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add the rest of the app
COPY . /myapp

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
