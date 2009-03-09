require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IssuesController do

  def mock_issue(stubs={})
    @mock_issue ||= mock_model(Issue, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all issues as @issues" do
      Issue.should_receive(:find).with(:all).and_return([mock_issue])
      get :index
      assigns[:issues].should == [mock_issue]
    end

    # describe "with mime type of xml" do
    #   
    #   it "should render all issues as xml" do
    #     request.env["HTTP_ACCEPT"] = "application/xml"
    #     Issue.should_receive(:find).with(:all).and_return(issues = mock("Array of Issues"))
    #     issues.should_receive(:to_xml).and_return("generated XML")
    #     get :index
    #     response.body.should == "generated XML"
    #   end
    # 
    # end

  end

  describe "responding to GET show" do

    it "should expose the requested issue as @issue" do
      Issue.should_receive(:find).with("37").and_return(mock_issue)
      get :show, :id => "37"
      assigns[:issue].should equal(mock_issue)
    end
    
    # describe "with mime type of xml" do
    # 
    #   it "should render the requested issue as xml" do
    #     @request.env["HTTP_ACCEPT"] = "application/xml"
    #     Issue.should_receive(:find).with("37").and_return(mock_issue)
    #     mock_issue.should_receive(:to_xml).and_return("generated XML")
    #     get :show, :id => "37", :format => :xml
    #     response.body.should == "generated XML"
    #   end
    # 
    # end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new issue as @issue" do
      Issue.should_receive(:new).and_return(mock_issue)
      get :new
      assigns[:issue].should equal(mock_issue)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested issue as @issue" do
      Issue.should_receive(:find).with("37").and_return(mock_issue)
      get :edit, :id => "37"
      assigns[:issue].should equal(mock_issue)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created issue as @issue" do
        Issue.should_receive(:new).with({'these' => 'params'}).and_return(mock_issue(:save => true))
        post :create, :issue => {:these => 'params'}
        assigns(:issue).should equal(mock_issue)
      end

      it "should redirect to the created issue" do
        Issue.stub!(:new).and_return(mock_issue(:save => true))
        post :create, :issue => {}
        response.should redirect_to(issue_url(mock_issue))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved issue as @issue" do
        Issue.stub!(:new).with({'these' => 'params'}).and_return(mock_issue(:save => false))
        post :create, :issue => {:these => 'params'}
        assigns(:issue).should equal(mock_issue)
      end

      it "should re-render the 'new' template" do
        Issue.stub!(:new).and_return(mock_issue(:save => false))
        post :create, :issue => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested issue" do
        Issue.should_receive(:find).with("37").and_return(mock_issue)
        mock_issue.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :issue => {:these => 'params'}
      end

      it "should expose the requested issue as @issue" do
        Issue.stub!(:find).and_return(mock_issue(:update_attributes => true))
        put :update, :id => "1"
        assigns(:issue).should equal(mock_issue)
      end

      it "should redirect to the issue" do
        Issue.stub!(:find).and_return(mock_issue(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(issue_url(mock_issue))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested issue" do
        Issue.should_receive(:find).with("37").and_return(mock_issue)
        mock_issue.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :issue => {:these => 'params'}
      end

      it "should expose the issue as @issue" do
        Issue.stub!(:find).and_return(mock_issue(:update_attributes => false))
        put :update, :id => "1"
        assigns(:issue).should equal(mock_issue)
      end

      it "should re-render the 'edit' template" do
        Issue.stub!(:find).and_return(mock_issue(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested issue" do
      Issue.should_receive(:find).with("37").and_return(mock_issue)
      mock_issue.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the issues list" do
      Issue.stub!(:find).and_return(mock_issue(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(issues_url)
    end

  end

end
