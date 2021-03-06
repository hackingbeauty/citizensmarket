namespace :db do
  
  desc "Erase and fill database with random test data"
  namespace :populate do
    
    task :small => :environment do
      Rake::Task['db:populate_issues'].invoke

      User.delete_all

      User.populate 1 do |user| # user with roles = [:contributor]
        user.login = "contributor@citizensmarket.org"
        user.email = "contributor@citizensmarket.org"
        user.firstname = "Joe"
        user.lastname = "Contributor"
        user.profile = {:location => 'Cambridge, MA', :website => 'www.foo.com'}
        user.roles = [[:contributor]]
        user.activated_at = 1.second.ago
        user.state = "active"
        user.crypted_password = "27705dff13cb5891f6867c04a95f8eb6a02e0a30" # password = 'password'
        user.salt = "3d4b9c8d689a0c58eb25ac6629a51fd86dae0e38"
      end

      [
        ["sdemessieres", "Stephane", "De Messieres"],
        ["kmagida", "Kyle", "Magida"],
        ["iwhol", "Isaac", "Whol"],
        ["gmatthews", "Grace", "Matthews"],
        ["mmuskardin", "Mark", "Muskardin"],
        ["lgriffiths", "Luke", "Griffiths"],
      ].each do |opts|
        User.populate 1 do |user|
          user.login = "#{opts[0]}@citizensmarket.org"
          user.email = "#{opts[0]}@citizensmarket.org"
          user.firstname = "#{opts[1]}"
          user.lastname = "#{opts[2]}"
          user.profile = {:location => 'Cambridge, MA', :website => 'www.foo.com'}
          user.roles = [[:contributor]]
          user.activated_at = 1.second.ago
          user.state = "active"
          user.crypted_password = "27705dff13cb5891f6867c04a95f8eb6a02e0a30" # password = 'password'
          user.salt = "3d4b9c8d689a0c58eb25ac6629a51fd86dae0e38"
        end
      end

      User.populate 1 do |user| # user with roles = [:admin]
        user.login = "admin@citizensmarket.org"
        user.email = "admin@citizensmarket.org"
        user.firstname = "Joe"
        user.lastname = "Admin"
        user.profile = {:location => 'Cambridge, MA', :website => 'www.foo.com'}
        user.roles = [[:admin]]
        user.activated_at = 1.second.ago
        user.state = "active"
        user.crypted_password = "f14905ba1f944ee46d0928c0c925deb006830d55" # password = 'password'
        user.salt = "d75d18195fd3811e368c278204d2d3ef34d79129"
      end

      User.all.each(&:initialize_default_issue_weights)

      [Company, Brand, Review, ReviewIssue].each(&:delete_all)

      possible_brands = 'BigRig, BigSnacks, DrillOil, LuxLube, SeaOil, Airhair, Lots \'O Locks, Tress Finesse, YouScrub, FairFace, FairHair, FairSkin, Fossil Fools, LoneStar, QwikLube, Mohawk Master, Nectar, ShockWave, SudsySoap, Goop, Goopaline, Goopex, GoopyGas, ExactExtract, Lucky Oil, Shale Sale Company, Conditional Love, Freshin, ManMane, Shaggy, Queen, Royal Refineries, FrizzWhiz, Musky Shampoo, Shower Power, SudsyGrip, Radiance, Thermo-Brush, Wash \'N Go, XX Appeal, Zesty'.split(', ')

      Company.populate 10 do |company|
        company.name = Faker::Company.name
        #company.description = Populator.sentences(2..10)
        company.description = "#{company.name} is a multinational corporation with joint headquarters in London and Amsterdam that began as a hair care company and now owns many of the world's consumer product brands in personal care products, cleaning agents, foods and beverages. Universal Hair Care Inc. employed 151,000 people and had a worldwide revenue of $33.8 billion in 2009."
        company.website_url = "http://www.#{Faker::Internet.domain_name}"
        company.info = { "Type" => "Public (Euronext: OR)", 
                         "Founded" => "1909",
                         "Founder" => "Eugène Schueller",
                         "Headquarters" => "Clichy , France",
                         "Key people" => "Jean-Paul Agon (CEO), Lindsay Owen-Jones (Chairman of the board), Liliane Bettencourt (Non-executive director and major shareholder)",
                         "Revenue" => "€17.06 billion (2007)",
                         "Operating Income" => "€2.827 billion (2007)",
                         "Profit" => "€2.039 billion (2007)",
                         "Employees" => "63,360 (2007)",
                         "Website" => "www.loreal.com"
                          }
        Brand.populate 0..5 do |brand|
          brand.company_id = company.id
          brand.name = possible_brands.delete(possible_brands.rand) || Populator.words(1..3).titleize
          brand.description = Populator.sentences(2..10)
        end
        Review.populate 0..10 do |review|
          ReviewIssue.populate 0..5 do |review_issue|
            review_issue.review_id = review.id
            review_issue.issue_id = Issue.all.rand.id
          end
          review.rating = 1..5
          review.user_id = [1, 2]
          review.company_id = company.id
          review.body = Populator.paragraphs(2..10)
          review.status = ['draft', 'published']
        end
      end
      
    end
    
    task :large => :environment do
      Rake::Task['db:populate_issues'].invoke

      User.delete_all

      User.populate 1 do |user| # user with roles = [:contributor]
        user.login = "contributor@citizensmarket.org"
        user.email = "contributor@citizensmarket.org"
        user.firstname = "Joe"
        user.lastname = "Contributor"
        user.profile = {:location => 'Cambridge, MA', :website => 'www.foo.com'}
        user.roles = [[:contributor]]
        user.activated_at = 1.second.ago
        user.state = "active"
        user.crypted_password = "27705dff13cb5891f6867c04a95f8eb6a02e0a30" # password = 'password'
        user.salt = "3d4b9c8d689a0c58eb25ac6629a51fd86dae0e38"
      end

      [
        ["sdemessieres", "Stephane", "De Messieres"],
        ["kmagida", "Kyle", "Magida"],
        ["iwhol", "Isaac", "Whol"],
        ["gmatthews", "Grace", "Matthews"],
        ["mmuskardin", "Mark", "Muskardin"],
        ["lgriffiths", "Luke", "Griffiths"],
      ].each do |opts|
        User.populate 1 do |user|
          user.login = "#{opts[0]}@citizensmarket.org"
          user.email = "#{opts[0]}@citizensmarket.org"
          user.firstname = "#{opts[1]}"
          user.lastname = "#{opts[2]}"
          user.profile = {:location => 'Cambridge, MA', :website => 'www.foo.com'}
          user.roles = [[:contributor]]
          user.activated_at = 1.second.ago
          user.state = "active"
          user.crypted_password = "27705dff13cb5891f6867c04a95f8eb6a02e0a30" # password = 'password'
          user.salt = "3d4b9c8d689a0c58eb25ac6629a51fd86dae0e38"
        end
      end

      User.populate 1 do |user| # user with roles = [:admin]
        user.login = "admin@citizensmarket.org"
        user.email = "admin@citizensmarket.org"
        user.firstname = "Joe"
        user.lastname = "Admin"
        user.profile = {:location => 'Cambridge, MA', :website => 'www.foo.com'}
        user.roles = [[:admin]]
        user.activated_at = 1.second.ago
        user.state = "active"
        user.crypted_password = "f14905ba1f944ee46d0928c0c925deb006830d55" # password = 'password'
        user.salt = "d75d18195fd3811e368c278204d2d3ef34d79129"
      end

      User.all.each(&:initialize_default_issue_weights)

      [Company, Brand, Review, ReviewIssue].each(&:delete_all)

      possible_brands = 'BigRig, BigSnacks, DrillOil, LuxLube, SeaOil, Airhair, Lots \'O Locks, Tress Finesse, YouScrub, FairFace, FairHair, FairSkin, Fossil Fools, LoneStar, QwikLube, Mohawk Master, Nectar, ShockWave, SudsySoap, Goop, Goopaline, Goopex, GoopyGas, ExactExtract, Lucky Oil, Shale Sale Company, Conditional Love, Freshin, ManMane, Shaggy, Queen, Royal Refineries, FrizzWhiz, Musky Shampoo, Shower Power, SudsyGrip, Radiance, Thermo-Brush, Wash \'N Go, XX Appeal, Zesty'.split(', ')

      Company.populate 100 do |company|
        company.name = Faker::Company.name
        #company.description = Populator.sentences(2..10)
        company.description = "#{company.name} is a multinational corporation with joint headquarters in London and Amsterdam that began as a hair care company and now owns many of the world's consumer product brands in personal care products, cleaning agents, foods and beverages. Universal Hair Care Inc. employed 151,000 people and had a worldwide revenue of $33.8 billion in 2009."
        company.website_url = "http://www.#{Faker::Internet.domain_name}"
        company.info = { "Type" => "Public (Euronext: OR)", 
                         "Founded" => "1909",
                         "Founder" => "Eugène Schueller",
                         "Headquarters" => "Clichy , France",
                         "Key people" => "Jean-Paul Agon (CEO), Lindsay Owen-Jones (Chairman of the board), Liliane Bettencourt (Non-executive director and major shareholder)",
                         "Revenue" => "€17.06 billion (2007)",
                         "Operating Income" => "€2.827 billion (2007)",
                         "Profit" => "€2.039 billion (2007)",
                         "Employees" => "63,360 (2007)",
                         "Website" => "www.loreal.com"
                          }
        Brand.populate 0..20 do |brand|
          brand.company_id = company.id
          brand.name = possible_brands.delete(possible_brands.rand) || Populator.words(1..3).titleize
          brand.description = Populator.sentences(2..10)
        end
        Review.populate 0..100 do |review|
          ReviewIssue.populate 0..5 do |review_issue|
            review_issue.review_id = review.id
            review_issue.issue_id = Issue.all.rand.id
          end
          review.rating = 1..5
          review.user_id = [1, 2]
          review.company_id = company.id
          review.body = Populator.paragraphs(2..10)
          review.status = ['draft', 'published']
        end
      end
      
    end
    
  end
  
  desc  "Erase and populate issues"
  task :populate_issues => :environment do
    
    Issue.delete_all
    
    issues = Array.new
    
    Hash.new.with_options :category => "Environment" do |issue|
      issues << issue.merge({:name => 'Research & Development', :description => 'Renewable Energy, Sustainable Products & Services'})
      issues << issue.merge({:name => 'Conservation', :description => 'Materials Used, Recycling, Energy, Water, Transport'})
      issues << issue.merge({:name => 'Emissions, Effluent & Waste Management', :description => 'Greenhouse Gases, Ozone Depletion, Waste Disposal, Spills'})
      issues << issue.merge({:name => 'Biodiversity', :description => 'Impact on Habitats and Protected Areas'})
    end
    
    Hash.new.with_options :category => "Economic Development" do |issue|
      issues << issue.merge({:name => 'Economic Performance', :description => 'Money Generated & Distributed, Financial Assistance from Government'})
      issues << issue.merge({:name => 'Market Presence', :description => 'Wages Compared to Local Minimum, Use of Local Suppliers & Local Hires'})
      issues << issue.merge({:name => 'Indirect Economic Impacts', :description => 'Infrastructure Development, Other Indirect Impacts'})
    end
    
    Hash.new.with_options :category => "Society" do |issue|
      issues << issue.merge({:name => 'Corruption & Bribery', :description => 'Illegal Influence: Incidences, Oversight, Training, Response'})
      issues << issue.merge({:name => 'Public Policy', :description => 'Legal Influence: Lobbying, Political Contributions'})
      issues << issue.merge({:name => 'Anti-Competitive Behavior', :description => 'Anti-Trust, Monopoly Practices'})
      issues << issue.merge({:name => 'Executive Compensation', :description => 'Executive Pay & Benefits, Golden Parachutes'})
      issues << issue.merge({:name => 'Investment & Procurement Practices', :description => 'Sustainability Screening for Suppliers / Investments, Employee Training'})
      issues << issue.merge({:name => 'Security Practices', :description => 'Operations in Conflict Zones, Complicity With Repressive Security Forces'})
      issues << issue.merge({:name => 'Indigenous Rights', :description => 'Land Appropriations and Other Violations of Rights of Indigenous Peoples'})
      issues << issue.merge({:name => 'Reporting & Disclosure', :description => 'Transparency, Quality of Sustainability Reports and Publicly Available Data'})
    end
    
    Hash.new.with_options :category => "Labor Practices" do |issue|
      issues << issue.merge({:name => 'Employment Stability & Benefits', :description => 'Workforce Turnover, Family Benefits, Child Care, Retirement, Health Care'})
      issues << issue.merge({:name => 'Labor/Management Relations', :description => 'Unions, Freedom of Association and Collective Bargaining'})
      issues << issue.merge({:name => 'Occupational Health & Safety', :description => 'Injury & Fatality Rates, Prevention Measures'})
      issues << issue.merge({:name => 'Training & Education', :description => 'Performance Reviews, Professional Development, Managing Career Endings'})
      issues << issue.merge({:name => 'Diversity & Equal Opportunity', :description => 'Parity in Wages and Executive/Board Representation, Cultural Competence, for Minorities, Women, LGBT, People With Disabilities'})
      issues << issue.merge({:name => 'Forced, Compulsory or Child Labor', :description => 'Slavery, Human Trafficking, Child Labor'})
    end
    
    Hash.new.with_options :category => "Product Responsibility" do |issue|
      issues << issue.merge({:name => 'Customer Health & Safety', :description => 'Quality Assurance, Consumer Illnesses/Injuries/Fatalities'})
      issues << issue.merge({:name => 'Labeling & Marketing Communications', :description => 'Responsible Advertising, Consumer Information'})
      issues << issue.merge({:name => 'Customer Privacy', :description => 'Consumer Complaints, Loss of Consumer Data'})
      issues << issue.merge({:name => 'Animal Testing', :description => 'Humane, Inhumane, Use of Alternatives'})
    end
    
    Issue.create(issues)
    
  end
  
end