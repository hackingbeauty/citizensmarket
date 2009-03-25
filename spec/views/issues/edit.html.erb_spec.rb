require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/issues/edit.html.erb" do
  
  before(:each) do
    assigns[:issue] = @issue = stub_model(Issue,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description"
    )
    
  end

  it "should render edit form" do
    render "/issues/edit.html.erb"
    
    response.should have_tag("form[action=#{issue_path(@issue)}][method=post]") do
      with_tag('input#issue_name[name=?]', "issue[name]")
      with_tag('textarea#issue_description[name=?]', "issue[description]")
    end
  end
end


