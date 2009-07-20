namespace :sweatshop do

  # Work whether RSpec is in use or not
  if File.exists?("#{RAILS_ROOT}/spec") && File.directory?("#{RAILS_ROOT}/spec")
    FOLDER = "#{RAILS_ROOT}/spec"
  else
    FOLDER = "#{RAILS_ROOT}/test"
  end

  desc "Generate Factory Girl factories for all ActiveRecord Models"
  task :generate do
    generate_models('factories', ENV['MODELS'])
  end

  namespace :generate do

    desc "Generate Factory Girl factories for all ActiveRecord Models"
    task :factories do
      generate_models('factories', ENV['MODELS'])
    end

    desc "Generate Machinist blueprints for all ActiveRecord Models"
    task :blueprints do
      generate_models('blueprints', ENV['MODELS'])
    end

  end

  def generate_models(produces, specific_models = '')
    require "#{RAILS_ROOT}/config/environment"

    updated_models = []

    if specific_models
      models_to_factorize = specific_models.split(" ").map {|m| m.constantize}
    else
      models_to_factorize = models
    end

    models_to_factorize.each{ |model| updated_models << model.to_s if generate_model(model, produces) }

    print_outro(updated_models, produces)
  end


  def generate_model(model, produces)
    name = model.to_s.tableize.singularize
    out_path = "#{FOLDER}/#{produces}.rb"

    begin
      out_file = File.open(out_path, "a")

      # Produce an error BEFORE we write to the file
      test = model.columns_hash

      b_var = name[0...1]
      if produces == 'blueprints'
        out_file.puts "\n#{model.to_s}.blueprint do"
      else
        out_file.puts "\nFactory.define :#{name} do |#{b_var}|"
      end

      model.columns_hash.each_pair do |key, val|
        unless key =~ /^(id|type)$/
          if key =~ /([a-z_]*)_id/ && val.type.to_s == "integer"
            # Example #=> g.organization { |o| o.association(:organization) }
            key = "#{$1}"
            if produces == "blueprints"
              value = ""
            else
              value = "{ |a| a.association(:#{$1.to_sym}) }"
            end
          else
            value = case val.type.to_s
              when "string", "text": "'foo'"
              when "integer": 1
              when "float": 1.0
              when "decimal": 1.0
              when "date": "'#{Date.today}'"
              when "datetime", "time", "timestamp": "'#{Time.now}'"
              when "boolean": false
              when "binary": "''"
            end
          end

          if produces == "blueprints"
            out_file.puts "  #{key} #{value}"
          else
            out_file.puts "  #{b_var}.#{key} #{value}"
          end
        end
      end

      out_file.puts "end\n"
      out_file.close
    rescue Exception => e
      puts "I can't generate a #{produces.singularize} for '#{model}'!"
      false
    end

    true
  end

  def models
    Dir.glob("#{RAILS_ROOT}/app/models/*.rb").map{|p| File.basename(p, ".rb").camelize.constantize}.select{|m| m < ActiveRecord::Base}
  end

  def print_outro(models, produces)
    puts "\nCreated #{produces} for: \n#{models.to_sentence}"
    helper = if FOLDER == "#{RAILS_ROOT}/spec" then "spec/spec_helper.rb" else "test/test_helper.rb" end

    if produces == 'blueprints'
      puts <<-END

Make sure you require the blueprints in #{helper}:
  require File.expand_path(File.dirname(__FILE__)) + '/blueprints'
Also, in the class Test::Unit::TestCase block in your test_helper.rb, add:
  setup { Sham.reset }
or, if you're on RSpec, in the Spec::Runner.configure block in your spec_helper.rb, add:
  config.before(:each) { Sham.reset }

      END
    else
      puts <<-END

Make sure you put the two following lines into #{helper}:
  require 'factory_girl'
  require File.expand_path(File.dirname(__FILE__)) + '/factories'

      END
    end
  end

end
