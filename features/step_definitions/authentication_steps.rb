Given /^I am logged in as an? (.*?(?= user)) user$/ do |role|
  
  Given %{an activated #{role} user named "#{role}"}
  #@user = Factory.create(:user, :email => "#{role}@citizensmarket.org", :password => 'secret', :password_confirmation => 'secret', :roles => [role.to_sym], :terms_of_use => "1")
  
  #raise "@user.state = #{@user.state}"
  #@user.register!
  #@user.activate!
  visit "/login"
  fill_in "Email", :with => "#{role}@citizensmarket.org"
  fill_in "Password", :with => 'secret'
  click_button "login-submit"
  
  response.should contain(Regexp.compile("success"))
  response.should contain(Regexp.compile("logged in"))
  
end

Given /^I am not logged in/ do
  visit "/logout"
end

Given /^an activated (.*?(?= user)) user named "([^"]*)"$/ do |role, name| #"
  @user = user_named(name)
  @user.roles = [role.to_sym]
  @user.save
end

def user_named(name)
  user = User.find_by_login(name.downcase+'@citizensmarket.org') || Factory.create(:user, :email => "#{name.downcase}@citizensmarket.org", :password => 'secret', :password_confirmation => 'secret', :terms_of_use => "1")
  
  unless user.state == 'active'
    user.register!
    user.activate!
  end
  user
end
