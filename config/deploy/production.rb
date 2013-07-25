set :branch, "production"
set :rails_env, "production"
set :application, "tedx-brisbane-#{rails_env}"

server '54.253.255.215', :app, :web, :db, :sidekiq, :primary => true
