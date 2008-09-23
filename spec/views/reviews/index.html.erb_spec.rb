require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reviews/index.html.erb" do
  include ReviewsHelper
  
  before(:each) do
    assigns[:reviews] = [
      stub_model(Review,
        :body => "value for body",
        :status => "value for status"
      ),
      stub_model(Review,
        :body => "value for body",
        :status => "value for status"
      )
    ]
  end

  it "should render list of reviews" do
    render "/reviews/index.html.erb"
    response.should have_tag("tr>td", "value for body", 2)
    response.should have_tag("tr>td", "value for status", 2)
  end
end

