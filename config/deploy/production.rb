set :branch, "master"
set :rails_env, "production"
set :application, "tedx-brisbane-#{rails_env}"

server '54.252.118.201', :app, :web, :db, :sidekiq, :primary => true
