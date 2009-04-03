require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/change_password.html.erb" do
  
  before(:each) do
    # doesn't require any assigns - LG
    #assigns[:user] = 
    
    @current_user = stub_model(User,
      :id => 1,
      :firstname => "value for firstname",
      :lastname => "value for lastname",
      :email => "value for email",
      :location => "value for location",
      :website => "value for website"
    )
    
    @controller.instance_variable_set(:@url, (ActionController::UrlRewriter.new @request, {}))
    
    @controller.stub!(:current_user).and_return(@current_user)
    
    #template.stub!(:object_url).and_return(user_path(@user))
    #template.stub!(:edit_object_url).and_return(edit_user_path(@user))
    
  end

  it "should render change password form" do
    render "/users/change_password.html.erb"
    
    response.should have_tag("form[action=#{update_password_path}][method=post]") do
      with_tag("input[name='old_password']")
      with_tag("input[name='password']")
      with_tag("input[name='password_confirmation']")
    end
  end
end


