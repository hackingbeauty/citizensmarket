require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AboutController do

  #Delete these examples and add some real ones
  it "should use AboutController" do
    controller.should be_an_instance_of(AboutController)
  end


  describe "GET 'team'" do
    it "should be successful" do
      get 'team'
      response.should be_success
    end
  end

  describe "GET 'model'" do
    it "should be successful" do
      get 'model'
      response.should be_success
    end
  end

  describe "GET 'methods'" do
    it "should be successful" do
      get 'methods'
      response.should be_success
    end
  end

  describe "GET 'faq'" do
    it "should be successful" do
      get 'faq'
      response.should be_success
    end
  end
end
