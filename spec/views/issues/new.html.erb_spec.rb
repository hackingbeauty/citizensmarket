require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/issues/new.html.erb" do
  include IssuesHelper
  
  before(:each) do
    assigns[:issue] = stub_model(Issue,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "should render new form" do
    render "/issues/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", issues_path) do
      with_tag("input#issue_name[name=?]", "issue[name]")
      with_tag("textarea#issue_description[name=?]", "issue[description]")
    end
  end
end


