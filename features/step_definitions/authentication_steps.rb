Given /^I am logged in as an? (.*?(?= user)) user$/ do |role|
  @user = Factory.create(:user, :email => "#{role}@citizensmarket.org", :password => 'secret', :password_confirmation => 'secret', :roles => [role.to_sym], :terms_of_use => "1")
  
  #raise "@user.state = #{@user.state}"
  @user.register!
  @user.activate!
  visit "/login"
  fill_in "Email", :with => "#{role}@citizensmarket.org"
  fill_in "Password", :with => 'secret'
  click_button "login-submit"
  
  response.should contain(Regexp.compile("You have successfully logged in to your #{role} account"))
  
end
