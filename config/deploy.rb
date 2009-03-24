set :application, "citizensmarket"
default_run_options[:pty]
set :repository,  "git@github.com:Sporky023/citizensmarket.git"

set :scm, "git"
#set :scm_passphrase, ""



set :branch, "master"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "staging.citizensmarket.org"
role :web, "staging.citizensmarket.org"
role :db,  "staging.citizensmarket.org", :primary => true

set :user, "adeploy"


desc "Create database.yml in shared/config" 
task :after_setup do
  database_configuration = <<-EOF
  production:
    adapter: mysql
    encoding: utf8
    database: citizensmarket_production
    username: root
    password: Scm248
    
EOF

  run "mkdir -p #{deploy_to}/#{shared_dir}/config" 
  put database_configuration, "#{deploy_to}/#{shared_dir}/config/database.yml" 
end

desc "Link in the production database.yml" 
task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml" 
  run "chmod 755 #{latest_release}/script/spin"
end

### the following is per advice at http://thinedgeofthewedge.blogspot.com/2007/08/mongrel-and-capistrano-20.html
# added by Luke on 2009-03-24
namespace :deploy do
  namespace :thin do
    [:stop, :start, :restart ].each do |t|
      task t, :roles => :app do
        invoke_command "/etc/init.d/thin #{t.to_s}"
      end
    end
  end
  
  desc "Custom restart task for thin cluster"
  task :restart, :roles => :app do #, :except => {:no_release => true}
    deploy.thin.restart
  end

  desc "Custom start task for thin cluster"
  task :start, :roles => :app do
    deploy.thin.start
  end

  desc "Custom stop task for thin cluster"
  task :stop, :roles => :app do
    deploy.thin.stop
  end
  
  
end


### end: added from http://thinedgeofthewedge.blogspot.com/2007/08/mongrel-and-capistrano-20.html