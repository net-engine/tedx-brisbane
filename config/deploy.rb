require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'sidekiq/capistrano'

set :pg_user, "ubuntu"
set :db_name, "tedx_brisbane"
set :bundle_flags, "--deployment --quiet --binstubs"

set :scm, :git
set :repository, "git@github.com:net-engine/tedx-brisbane.git"
ssh_options[:forward_agent] = true

default_run_options[:pty] = true
set :runner, 'netengine'
set :user, 'netengine'
set :use_sudo, false

set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :copy_strategy, :export
set :deploy_to, '/var/www/unicorn'
set :keep_releases, 5
set :sidekiq_role, :sidekiq

set :default_environment, {
  'RBENV_ROOT' => '/home/ubuntu/.rbenv',
  'PATH' => "/var/www/unicorn/current/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/aws/ec2-ami-tools/bin"
}

after "deploy:setup", "db:setup", "setup:postgresql"
after "deploy:update_code", "db:symlink", "payway:symlink"
after "db:init", "db:migrate", "db:seed"

load 'deploy/assets'
set :normalize_asset_timestamps, false

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    sudo "/etc/init.d/unicorn start"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    sudo "/etc/init.d/unicorn stop"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    deploy.upgrade
  end

  task :upgrade, :roles => :app, :except => { :no_release => true } do
    sudo "/etc/init.d/unicorn upgrade"
  end

  namespace :assets do
    task :precompile, :roles => assets_role, :except => { :no_release => true } do
      run <<-CMD.compact
        cd -- #{latest_release.shellescape} &&
        #{rake} RAILS_ENV=#{rails_env.to_s.shellescape} #{asset_env} assets:precompile
      CMD
    end
  end
end

namespace :sidekiq do
  task :start do
    run "/etc/init.d/sidekiq start"
  end
  task :restart do
    run "/etc/init.d/sidekiq restart"
  end
  task :quiet do
    sidekiq.stop
  end
  task :stop do
    run "/etc/init.d/sidekiq stop"
  end
end

namespace :payway do
  task :symlink do
    desc "Make symlink for the payway yml"
    run "ln -nfs #{shared_path}/config/payway.yml #{latest_release}/config/payway.yml"
  end
end

# Tasks for Database configuration
namespace :db do
  task :symlink do
    desc "Make symlink for the database yaml"
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  task :setup do
    template = <<-EOF
#{rails_env}:
  adapter: postgresql
  encoding: unicode
  host: #{Capistrano::CLI.ui.ask "Database host: "}
  database: #{db_name}
  username: #{pg_user}
  password: #{Capistrano::CLI.ui.ask "Database password: "}
  pool: 30
EOF

    run "mkdir -p  #{shared_path}/config"
    put template, "#{shared_path}/config/database.yml"
  end

  desc "Init Database"
  task :init, :roles => :db do
    puts "\n\n=== Creating the #{rails_env} Database! ===\n\n"
    run "cd #{current_path}; rake db:create RAILS_ENV=#{rails_env}"
  end

  desc "Migrate Database"
  task :migrate, :roles => :db do
    puts "\n\n=== Migrating the #{rails_env} Database! ===\n\n"
    run "cd #{current_path}; rake db:migrate RAILS_ENV=#{rails_env}"
  end

  desc "Seed Database"
  task :seed, :roles => :db do
    puts "\n\n=== Seeding the #{rails_env} Database! ===\n\n"
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end

# Server setup
namespace :setup do

  task :postgresql, :roles => :db do
    puts "\n\n=== Setup postgresql ===\nCorrent conf limit connections to localhost\n\n"
    sudo "su postgres -c \"psql -d template1 -U postgres -c \\\"CREATE USER #{pg_user} WITH PASSWORD '#{pg_password}'\\\"\""
    sudo "su postgres -c \"psql -d template1 -U postgres -c \\\"GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO #{pg_user};\\\"\""
    sudo "su postgres -c \"psql -d template1 -U postgres -c \\\"ALTER USER #{pg_user} CREATEDB;\\\"\""
    sudo "su postgres -c \"psql -d template1 -U postgres -c \\\"CREATE DATABASE #{db_name} OWNER #{pg_user};\\\"\""
  end

end
