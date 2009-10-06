Given /^a company with name "([^\"]*)"$/ do |name|
  company = Factory.create(:company, :name => name)
  company.save.should be_true
end

Given /^a company with name "([^\"]*)" and description "([^\"]*)"$/ do |name, description|
  company = Factory.create(:company, :name => name, :description => description)
  company.save.should be_true
end
