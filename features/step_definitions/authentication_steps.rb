Given /^I am logged in as an admin user$/ do
  @user = Factory.create(:user, :email => 'admin@citizensmarket.org', :password => 'secret', :password_confirmation => 'secret', :roles => [:admin], :terms_of_use => "1")
  
  #raise "@user.state = #{@user.state}"
  @user.register!
  @user.activate!
  visit "/login"
  fill_in "Email", :with => "admin@citizensmarket.org"
  fill_in "Password", :with => 'secret'
  click_button "login-submit"
  
  response.should contain("You have successfully logged in as an administrator")
  
  
end
