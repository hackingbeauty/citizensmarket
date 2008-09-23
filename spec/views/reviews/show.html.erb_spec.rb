require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reviews/show.html.erb" do
  include ReviewsHelper
  
  before(:each) do
    assigns[:review] = @review = stub_model(Review,
      :body => "value for body",
      :status => "value for status"
    )
  end

  it "should render attributes in <p>" do
    render "/reviews/show.html.erb"
    response.should have_text(/value\ for\ body/)
    response.should have_text(/value\ for\ status/)
  end
end
