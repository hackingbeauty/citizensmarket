require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CompaniesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "companies", :action => "index").should == "/companies"
    end
  
    it "should map #new" do
      route_for(:controller => "companies", :action => "new").should == "/companies/new"
    end
  
    it "should map #show" do
      route_for(:controller => "companies", :action => "show", :id => "1").should == "/companies/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "companies", :action => "edit", :id => "1").should == "/companies/1/edit"
    end
  
    # it "should map #update" do
    #   route_for(:controller => "companies", :action => "update", :id => "1").should == "/companies/1"
    # end
    #   
    # it "should map #destroy" do
    #   route_for(:controller => "companies", :action => "destroy", :id => "1").should == "/companies/1"
    # end

  end
  
  describe "route recognition" do
     it "should generate params for #index" do
       params_from(:get, "/companies").should == {:controller => "companies", :action => "index"}
     end

     it "should generate params for #new" do
       params_from(:get, "/companies/new").should == {:controller => "companies", :action => "new"}
     end

     it "should generate params for #create" do
       params_from(:post, "/companies").should == {:controller => "companies", :action => "create"}
     end

     it "should generate params for #show" do
       params_from(:get, "/companies/1").should == {:controller => "companies", :action => "show", :id => "1"}
     end

     it "should generate params for #edit" do
       params_from(:get, "/companies/1/edit").should == {:controller => "companies", :action => "edit", :id => "1"}
     end

     it "should generate params for #update" do
       params_from(:put, "/companies/1").should == {:controller => "companies", :action => "update", :id => "1"}
     end

     it "should generate params for #destroy" do
       params_from(:delete, "/companies/1").should == {:controller => "companies", :action => "destroy", :id => "1"}
     end
   end
end