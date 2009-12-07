Given /an issue named "([^"]*)"$/ do |name|  #"
  @issue = Factory.create(:issue, :name => name, :description => "generic_description_#{Time.now.to_f}", :category => "generic_issue_category")
  @issue.save.should == true
end


When /^I pick "([^\"]*)" as the review issue$/ do |arg1|
  within '.review_issue_picker:first-of-type' do |foo|
    select arg1
  end
end


def issue_named(name)
  Issue.find_by_name(name) || Issue.create!(:name => name, :description => "description for issue #{name}", :category => "category for issue #{name}")
end