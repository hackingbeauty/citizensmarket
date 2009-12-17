#========================
#CONFIG
#========================
set :application, "staging.citizensmarket.org"
set :scm, "git"
set :repository,  "git@github.com:citizensmarket/citizensmarket.git"
set :branch, "master"
set :user, "deploy"
set :use_sudo, false #tells capistrano not to use root
default_run_options[:pty] = true #enables password entry for git
set :deploy_to, "/var/www/#{application}"
set :app_server, :passenger
set :deploy_via, :remote_cache #tells capistrano just to pull down updates, not your entire codebase over and over again
set :rails_env, "staging"
default_run_options[:pty] = true
#========================
#ROLES
#========================
role :app, "staging.citizensmarket.org"
role :web, "staging.citizensmarket.org"
role :db,  "staging.citizensmarket.org", :primary => true

#========================
#CUSTOM
#========================
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  task :stop, :roles => :app do
    # Do nothing.
  end
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end