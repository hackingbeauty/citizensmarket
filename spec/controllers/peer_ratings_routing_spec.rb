require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PeerRatingsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "peer_ratings", :action => "index").should == "/peer_ratings"
    end
  
    it "should map #new" do
      route_for(:controller => "peer_ratings", :action => "new").should == "/peer_ratings/new"
    end
  
    it "should map #show" do
      route_for(:controller => "peer_ratings", :action => "show", :id => 1).should == "/peer_ratings/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "peer_ratings", :action => "edit", :id => 1).should == "/peer_ratings/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "peer_ratings", :action => "update", :id => 1).should == "/peer_ratings/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "peer_ratings", :action => "destroy", :id => 1).should == "/peer_ratings/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/peer_ratings").should == {:controller => "peer_ratings", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/peer_ratings/new").should == {:controller => "peer_ratings", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/peer_ratings").should == {:controller => "peer_ratings", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/peer_ratings/1").should == {:controller => "peer_ratings", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/peer_ratings/1/edit").should == {:controller => "peer_ratings", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/peer_ratings/1").should == {:controller => "peer_ratings", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/peer_ratings/1").should == {:controller => "peer_ratings", :action => "destroy", :id => "1"}
    end
  end
end
