$LOAD_PATH.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib') if File.directory?(RAILS_ROOT + '/vendor/plugins/cucumber/lib')

unless ARGV.any? {|a| a =~ /^gems/}

begin
  require 'cucumber/rake/task'
  namespace :cucumber do
    
    Cucumber::Rake::Task.new({:focus => 'db:test:prepare'}, 'just focus') do |t|
      t.cucumber_opts = "--format pretty -t @focus"
    end

    Cucumber::Rake::Task.new({:nowip => 'db:test:prepare'}, 'exclude works in progress') do |t|
      t.cucumber_opts = "--format pretty -t ~@wip"
    end
    
  end

  task :focus => 'cucumber:focus'
  task :nowip => 'cucumber:nowip'
  
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end

end