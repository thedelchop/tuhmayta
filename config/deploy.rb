require 'bundler/capistrano'

set :application, "tuhmayta"
set :user, "deploy"

set :scm, :git
set :repository,  "git@github.com:thedelchop/#{application}.git"

set :deploy_to, "/var/www/apps/#{application}.synantus.com"

set :domain, "ares.synantus.com"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :runner, user

set :mongrel_servers, 3
set :mongrel_port, 8000
set :rails_env, 'production'

namespace :deploy do
  task :start do ; end
   
  task :stop do ; end
   
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end  
  
end

after 'deploy:update_code', 'deploy:symlink_shared'
