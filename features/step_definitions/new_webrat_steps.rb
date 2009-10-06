Then /^I should see "([^\"]*)" and "([^\"]*)"$/ do |text1, text2|
  response.should contain(text1)
  response.should contain(text2)
end
