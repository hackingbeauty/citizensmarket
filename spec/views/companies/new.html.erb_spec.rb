require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/companies/new" do
  before(:each) do
    render 'companies/new'
    @current_user = mock_model(User, :id => 1)
  end
  
  it "should provide a form to fill out" do
    response.should have_tag("form[action=#{companies_path}][method=post]") do
      with_tag("input[name='company[name]']")
      with_tag("textarea[name='company[description]']")
    end
  end
  
end
