When /^I try to get '([^\']*)'$/ do |url|
  visit url
end

When /^I send a packet with "([^\']*)'([^\']*)'"$/ do |http_method, url|
  http_method.strip!
  request_page(url, http_method, {})
end


Then /^I should see "([^\"]*)" and "([^\"]*)"$/ do |text1, text2|
  response.should contain(text1)
  response.should contain(text2)
end

Then /^I should see a fixed star rating$/ do
  response.should have_tag("span[class='fixed_star_rating']")
end

Then /^I should see a form$/ do
  response.should have_tag("form")
end

Then /^I should see an image with src "([^"]*)"$/ do |filename|  #"
  response.should have_selector("img[src*='#{filename}']")
end





