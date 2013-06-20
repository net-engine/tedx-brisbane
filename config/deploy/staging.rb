set :branch, "fix_active_admin_deploy"
set :rails_env, "staging"
set :application, "tedx-brisbane-#{rails_env}"

server 'ec2-54-253-12-8.ap-southeast-2.compute.amazonaws.com', :app, :web, :db, :primary => true
