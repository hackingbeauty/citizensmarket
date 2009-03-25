require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/issues/show.html.erb" do
  
  before(:each) do
    assigns[:issue] = @issue = stub_model(Issue,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "should render attributes in <p>" do
    render "/issues/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(//)
  end
end

