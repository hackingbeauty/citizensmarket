Given /an issue named "([^"]*)"$/ do |name|  #"
  @issue = Factory.create(:issue, :name => name, :description => "generic_description_#{Time.now.to_f}", :category => "generic_issue_category")
  @issue.save.should == true
end