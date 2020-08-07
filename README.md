# CW2 Hombase Application

Source code to accompany the CW2 project.

## Getting Started

### System dependencies

The application uses Rails 6.0. If you don't have Ruby installed on your machine, you can use [`rvm`](https://rvm.io) for versions management.

```sh
# using homebrew:
$ brew update
$ brew install rbenv

# install a Ruby version:
$ rbenv install 2.7.1

# Run a postgres database
$ brew install postgres
$ brew services start postgresql
```

### Ruby Dependencies

```sh
# install bundler if you don't already have it
$ gem install bundler
# install dependencies
$ bundle install
```

### Database setup

Postgres is used for the database.

```sh
# create the database
$ bin/rails db:create
# run migrations
$ bin/rails db:migrate
```

### Starting the Rails server

```sh
$ rails s
```

### Testing

```sh
# Run tests
$ rspec spec
```
