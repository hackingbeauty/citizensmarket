require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reviews/edit.html.erb" do
  include ReviewsHelper
  
  before(:each) do
    assigns[:review] = @review = stub_model(Review,
      :new_record? => false,
      :body => "value for body",
      :status => "value for status"
    )
  end

  it "should render edit form" do
    render "/reviews/edit.html.erb"
    
    response.should have_tag("form[action=#{review_path(@review)}][method=post]") do
      with_tag('textarea#review_body[name=?]', "review[body]")
      with_tag('input#review_status[name=?]', "review[status]")
    end
  end
end


