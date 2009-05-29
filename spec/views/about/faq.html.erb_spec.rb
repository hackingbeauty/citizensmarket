require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/about/faq" do
  before(:each) do
    render 'about/faq'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should have a header that reads the Frequently Asked Questions" do
    response.should have_tag('h2', %r[Frequently Asked Questions])
  end
end
