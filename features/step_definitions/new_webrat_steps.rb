Then /^I should see "([^\"]*)" and "([^\"]*)"$/ do |text1, text2|
  response.should contain(text1)
  response.should contain(text2)
end

Then /^I should see a fixed star rating$/ do
  response.should have_tag("span[class='fixed_star_rating']")
end
