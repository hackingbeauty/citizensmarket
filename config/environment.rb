
# for future generations, this app needs:
# sphinx
# imagemagick (or similar)
# mysql (until a transaction issue is resolved)

# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'resource_controller', :version => '0.5.2'
  config.gem 'active_presenter', :version => '0.0.3'
  config.gem 'rubyist-aasm', :version => '2.0.2', :lib => 'aasm', :source => 'http://gems.github.com'
  config.gem 'hpricot'
  config.gem 'json', :version => '1.1.3'
  config.gem 'populator'
  config.gem 'faker', :version => '0.3.1'
  config.gem 'RedCloth', :version => '4.1.9'
  config.gem 'gravtastic', :version => '2.0.0'
  config.gem "ambethia-smtp-tls", :lib => "smtp-tls", :source => "http://gems.github.com/"
  config.gem 'mislav-will_paginate', :version => '~> 2.2.3', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem 'stffn-declarative_authorization', :lib => 'declarative_authorization'
  config.time_zone = 'UTC'
  # config.gem 'thoughtbot-paperclip', :lib => "paperclip"
  config.gem 'paperclip', :source => 'http://gemcutter.org'
  config.gem 'haml', :version => '2.2.17'
  config.gem 'thinking-sphinx', :version => '1.3.15'
  
  
  # these four lines came from The RSpec Book, page 289
  config.gem 'rspec-rails', :lib => false
  config.gem 'rspec', :lib => false
  config.gem 'cucumber'
  config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'


  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_citizensmarket_session',
    :secret      => '87eb49c6406a7e35ab290bae7b50dbb130276887d6aa4f4cf7b9168dd9fd3a759215276d03566ec597eb60772bb30baafc4305590b1155758e996c401829eb4a'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  config.action_mailer.delivery_method = :smtp

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.active_record.observers = :user_observer

  # Load Presenters
  config.load_paths += %W( #{RAILS_ROOT}/app/presenters )
  
  #reCaptcha Keys
  ENV['RECAPTCHA_PUBLIC_KEY'] = '6LdoDAcAAAAAAJPWZ8_b8Nm2tvKqyet7hs3iXVjD'
  ENV['RECAPTCHA_PRIVATE_KEY'] = '6LdoDAcAAAAAAG8fzeLUZIxxxS72N-iOKp9G89is'
  
end

require 'memcache'
CACHE = MemCache.new('127.0.0.1')
