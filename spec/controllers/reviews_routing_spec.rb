require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReviewsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "reviews", :action => "index").should == "/reviews"
    end
  
    it "should map #new" do
      route_for(:controller => "reviews", :action => "new").should == "/rate"
    end
  
    it "should map #show" do
      route_for(:controller => "reviews", :action => "show", :id => "1").should == "/reviews/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "reviews", :action => "edit", :id => "1").should == "/reviews/1/edit"
    end
  
    # it "should map #update" do
    #   route_for(:controller => "reviews", :action => "update", :id => "1").should == "/reviews/1"
    # end
    #   
    # it "should map #destroy" do
    #   route_for(:controller => "reviews", :action => "destroy", :id => "1").should == "/reviews/1"
    # end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/reviews").should == {:controller => "reviews", :action => "index"}
    end
  
    #it "should generate params for #new" do
    #  params_from(:get, "/reviews/new").should == {:controller => "reviews", :action => "new"}
    #end
  
    #it "should generate params for #create" do
    #  params_from(:post, "/reviews").should == {:controller => "reviews", :action => "create"}
    #end
  
    #it "should generate params for #show" do
    #  params_from(:get, "/reviews/1").should == {:controller => "reviews", :action => "show", :id => "1"}
    #end
  
    it "should generate params for #edit" do
      params_from(:get, "/reviews/1/edit").should == {:controller => "reviews", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/reviews/1").should == {:controller => "reviews", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/reviews/1").should == {:controller => "reviews", :action => "destroy", :id => "1"}
    end
  end
end
