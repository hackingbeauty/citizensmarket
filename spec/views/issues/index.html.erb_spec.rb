require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/issues/index.html.erb" do
  
  before(:each) do
    assigns[:issues] = [
      stub_model(Issue,
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(Issue,
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "should render list of issues" do
    render "/issues/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
  end
end

