require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/about/model" do
  before(:each) do
    render 'about/model'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should have a header that reads the Our Model" do
    response.should have_tag('h2', %r[Our Model])
  end
end
