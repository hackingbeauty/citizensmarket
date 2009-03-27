require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/edit.html.erb" do
  
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :id => 1,
      :firstname => "value for firstname",
      :lastname => "value for lastname",
      :email => "value for email",
      :location => "value for location",
      :website => "value for website"
    )
  
  
    @controller.instance_variable_set(:@url, (ActionController::UrlRewriter.new @request, {}))
    
    template.stub!(:object_url).and_return(user_path(@user))
    template.stub!(:edit_object_url).and_return(edit_user_path(@user))
    
  end

  it "should render edit form" do
    render "/users/edit.html.erb"
    
    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag("input[name='user[firstname]']")
      with_tag("input[name='user[lastname]']")
      with_tag("input[name='user[email]']")
    end
  end
end


