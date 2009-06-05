require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CompaniesController do

  #Delete these examples and add some real ones
  it "should use CompaniesController" do
    controller.should be_an_instance_of(CompaniesController)
  end


  describe "GET 'edit'" do
    it "should be successful" do
      Company.should_receive(:find).with("1").and_return(mock_model(Company))
      get 'edit', :id => "1"
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get :show, :id => "1"
      response.should be_success
    end
  end
  
  describe "DELETE" do
    #TODO:  See reviews_contoller_spec for an example of how to delete.  Below probably doesn't work.
    # it "should delete a company" do
    #   post :show, :id => "1", :method => 'DELETE'
    #   response.should be_success
    #   
    #   Company.should_receive(:find).with("1").and_return(nil)
    #   get 'edit', :id => "1"
    #   response.should be_success
    # end 
  end
end
