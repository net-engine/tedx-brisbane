set :branch, "fix_active_admin_deploy"
set :rails_env, "staging"
set :application, "tedx-brisbane-#{rails_env}"

server '54.252.104.115', :app, :web, :db, :primary => true
