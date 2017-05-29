## About

“Adopt India” is to connect people who are socially responsible and to support and encourage civic participation in solving social issues.  http://adoptindia.org/

## Developer Notes

## How to run the app locally?
Install the right ruby and rails versions - 2.4.0 (ruby) with rvm
`rvm install 2.4.0`

`gem install bundler` to install the bundler gem.
`bundle install` to install the gems for the project.
`bundle exec rake db:create` to create the local database
`bundle exec rake db:migrate` to migrate
`bundle exec rake db:seed` to populate an initial list of social interests.

`bundle exec rails s` to start the server on port 3000



## Deployment Steps

* Run "bundle install" to install the dependencies.
* Run "rails s" to install the app on local host.
* Run "rails db:migrate" 
* Run "rails db:seed"


## Test Steps 

* TODO

