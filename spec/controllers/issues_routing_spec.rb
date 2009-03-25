require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IssuesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "issues", :action => "index").should == "/issues"
    end
  
    it "should map #new" do
      route_for(:controller => "issues", :action => "new").should == "/issues/new"
    end
  
    it "should map #show" do
      route_for(:controller => "issues", :action => "show", :id => "1").should == "/issues/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "issues", :action => "edit", :id => "1").should == "/issues/1/edit"
    end
  
    # it "should map #update" do
    #   route_for(:controller => "issues", :action => "update", :id => "1").should == "/issues/1"
    # end
  
    # it "should map #destroy" do
    #   route_for(:controller => "issues", :action => "destroy", :id => "1").should == "/issues/1"
    # end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/issues").should == {:controller => "issues", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/issues/new").should == {:controller => "issues", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/issues").should == {:controller => "issues", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/issues/1").should == {:controller => "issues", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/issues/1/edit").should == {:controller => "issues", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/issues/1").should == {:controller => "issues", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/issues/1").should == {:controller => "issues", :action => "destroy", :id => "1"}
    end
  end
end
