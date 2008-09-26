namespace :db do
  
  desc "Erase and fill database with random test data"
  task :populate => :environment do
    
    Rake::Task['db:populate_issues'].invoke
    
    [Company, Brand, Review, ReviewIssue].each(&:delete_all)
    
    Company.populate 10 do |company|
      company.name = Faker::Company.name
      company.description = Populator.sentences(2..10)
      company.website_url = "http://www.#{Faker::Internet.domain_name}"
      Brand.populate 0..20 do |brand|
        brand.company_id = company.id
        brand.name = Populator.words(1..3).titleize
        brand.description = Populator.sentences(2..10)
      end
      Review.populate 0..10 do |review|
        ReviewIssue.populate 0..5 do |review_issue|
          review_issue.review_id = review.id
          review_issue.issue_id = Issue.all.rand.id
          review_issue.rating = rand(9) + 1
        end
        review.company_id = company.id
        review.body = Populator.sentences(10..30)
        review.status = ['draft', 'published']
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
    

    
    Issue.create(issues)
    
  end
  
end