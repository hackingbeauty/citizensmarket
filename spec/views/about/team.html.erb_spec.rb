require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/about/team" do
  before(:each) do
    render 'about/team'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should have a header that reads the Our Team" do
    response.should have_tag('h2', %r[Our Team])
  end
end
