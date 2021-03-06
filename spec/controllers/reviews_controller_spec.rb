require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe ReviewsController do
  include AuthenticatedTestHelper
  
  fixtures :reviews
  before(:each) do
    login_as(mock_user)
    User.should_receive(:find).at_most(10).times.and_return(mock_user)
  end
  
  def mock_review(stubs={})
    @mock_review ||= mock_model(Review, stubs)
    @mock_review.stub!(:sources).and_return([]) unless @mock_review.respond_to?(:sources)
    @mock_review
  end
  
  describe "responding to GET index" do

    it "should expose all reviews as @reviews" do
      Review.should_receive(:find).with(:all).and_return([@mock_review])
      get :index
      assigns[:reviews].should == [@mock_review]
    end

  end

  describe "responding to GET show" do

    before(:each) do
      Review.should_receive(:find).with("37").and_return(mock_review(:status => "published"))
      get :show, :id => "37"
    end

    it "should return success" do
      response.should be_success
    end

    it "should expose the requested review as @review" do
      assigns[:review].should equal(mock_review)
    end
        
  end

  describe "responding to GET new" do
  
    it "should expose a new review as @review" do
      Review.should_receive(:new).and_return(mock_review(:sources => mock(:build => true)))
      get :new
      assigns[:review].should_not be_nil      
      assigns[:review].should equal(mock_review)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested review as @review" do
      Review.should_receive(:find).with("37").and_return(mock_review)
      get :edit, :id => "37"
      assigns[:review].should equal(mock_review)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created review as @review" do        
        post :create, :review => {
          :body => "body of review",
          :rating => "5",
          :company_id => "2",
          :issues => ["1"],
        }
        assigns[:review].should be_valid
        assigns[:review].company.should_not be_nil
        response.should redirect_to(my_reviews_url)
      end

      it "should redirect to the created review" do
        post :create, :review => {
          :body => "body of review",
          :rating => "5", 
          :company_id => "2",
          :issues => ["1", "2"]
        }
        assigns[:review].company should_not be_nil
        assigns[:review].should be_valid
        response.should redirect_to(my_reviews_url)
      end
      
    end
    
    describe "with invalid params" do

      it "should render the new action with the errors" do
        post :create, :review => {}
        response.should render_template('new')
        assigns[:review].errors.empty?.should_not be_true
      end
            
    end
    
    describe "with valid params and some sources" do
      
      it "should save the sources" do
        source_count_was = Source.count
        post :create, :review => {
          :body => "body of review",
          :rating => "5",
          :company_id => "2",
          :issues => ["1"],
          :sources_attributes => [
            {:title => "source 1 title", :url => "source 1 url"}, 
            {:title => "source 2 title", :url => "source 2 url"}
          ]
        }
        assigns[:review].should be_valid
        Source.count.should == source_count_was + 2
      end
      
    end
    
  end

  describe "responding to PUT udpate" do
    
    before do
      login_as(mock_user)
    end
    
    describe "with valid params" do
      it "should update the requested review" do
        Review.should_receive(:find).with("1").and_return(mock_review(:update_attributes => true))
        mock_review.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "1", "review" => {:these => 'params'}
      end

      it "should expose the requested review as @review" do
        Review.stub!(:find).and_return(mock_review(:update_attributes => true))
        put :update, :id => "1", :review => {}
        assigns(:review).should equal(mock_review)
      end

      it "should redirect to the review" do
        Review.stub!(:find).and_return(mock_review(:update_attributes => true))
        put :update, :id => "1", :review => {}
        response.should redirect_to(review_url(mock_review))
      end

    end
    
    describe "with valid params and updating associated sources" do
      
      fixtures :sources
      
      it "should confirm that we're using the right fixtures" do
        review = Review.find(1)
        # these next two lines just confirming assumptions about the fixtures
        review.should_not be_nil  
        review.sources.should_not be_empty
      end
      
      it "should be able to add a source" do
        source_count_was = Source.count
        put :update, :id => "1", :review => {
          :sources_attributes => [
            {"id" => '1', "title" => "source one title", "url" => "source one url", "_delete" => ""},
            {"title" => "source two title", "url" => "source two url"},  # <-- a new source
          ]
        }
        Source.count.should == source_count_was + 1
      end
      
      it "should be able to modify a source" do
        source_title_was = Source.find(1).title
        put :update, :id => "1", :review => {
          :sources_attributes => [
            {"id" => '1', "title" => "#{source_title_was}UPDATED!", "url" => "source one url", "_delete" => ""},
          ]
        }
        Source.find(1).title.should == "#{source_title_was}UPDATED!"
      end
      
      it "should be able to delete a source" do
        Source.find(1).should_not be_nil
        put :update, :id => "1", :review => {
          :sources_attributes => [
            {"id" => '1', "title" => "source one title", "url" => "source one url", "_delete" => "1"},
          ]
        }
        Source.find_by_id(1).should be_nil
      end
      
    end
    
    describe "with invalid params" do

      it "should update the requested review" do
        Review.should_receive(:find).with("2").and_return(mock_review(:update_attributes => true))
        mock_review.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "2", :review => {:these => 'params'}
      end

      it "should expose the review as @review" do
        Review.stub!(:find).and_return(mock_review(:update_attributes => false))
        put :update, :id => "1"
        assigns(:review).should equal(mock_review)
      end

      it "should re-render the 'edit' template" do
        Review.stub!(:find).and_return(mock_review(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end


  end

  describe "responding to DELETE destroy" do
    before(:each) do
      controller.stub!(:current_user).and_return(mock_model(User, :role_symobols => [:garmin, :admin]))
      @review = mock_model(Review, :destroy => true)
      Review.stub!(:find).and_return(@review)
    end
    
    it "should allow the action" do
      delete :destroy, :id => "1"''
      response.should_not have_text("You are not allowed to access this action."), "got the not-authorized message: '#{response.body}'"
    end
    
    it "should destroy the requested review" do
      Review.should_receive(:find).with("1").and_return(@review)
      delete :destroy, :id => "1"
    end
  
    it "should redirect to the reviews list" do
      Review.stub!(:find).and_return(@review)
      delete :destroy, :id => "1"
      response.should redirect_to(reviews_url)
    end

  end

end
