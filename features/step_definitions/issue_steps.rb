Given /an issue named "([^"]*)"$/ do |name|  #"
  @issue = Factory.create(:issue, :name => name)
end