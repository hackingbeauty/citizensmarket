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
