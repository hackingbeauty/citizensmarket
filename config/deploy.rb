#========================
#CONFIG
#========================
set :application, "staging.citizensmarket.org"
set :user, "deploy"
set :runner, user
default_run_options[:pty] = true #enables password entry for git
set :repository,  "git@github.com:citizensmarket/citizensmarket.git"
set :deploy_to, "/var/www/#{application}"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache #:copy#:remote_cache #tells capistrano just to pull down updates, not your entire codebase over and over again
set :scm, "git"
set :scm_verbose, true
set :branch, "master"
set :use_sudo, false #tells capistrano NOT to use root
set :app_server, :passenger
set :deploy_via, :remote_cache #tells capistrano just to pull down updates, not your entire codebase over and over again
set :rails_env, "staging"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true#allows the server to pull the latest code from github using my local private key and ssh agent
# default_environment["PATH"] = "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
set :sudo_password, true

# set :ssh_options, { :forward_agent => true } #allows the server to pull the latest code from github using my local private key and ssh agent




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
    run "cd #{deploy_to}; git pull"
    run "touch #{deploy_to}/tmp/restart.txt"
    # run "/etc/init.d/nginx start"
    
    # run "#{sudo} /etc/init.d/nginx start"
    
  end
  task :stop, :roles => :app do
    run "#{sudo} /etc/init.d/nginx stop"
  end
  desc "Restart Application"
  task :restart, :roles => :app do
    run "cd #{deploy_to}; git pull"
    run "touch #{deploy_to}/tmp/restart.txt"
    # run "/etc/init.d/nginx start"
  end
end