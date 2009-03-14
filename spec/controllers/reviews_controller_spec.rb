require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReviewsController do

  def mock_review(stubs={})
    @mock_review ||= mock_model(Review, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all reviews as @reviews" do
      Review.should_receive(:find).with(:all).and_return([mock_review])
      get :index
      assigns[:reviews].should == [mock_review]
    end

    describe "with mime type of xml" do
  
      it "should render all reviews as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Review.should_receive(:find).with(:all).and_return(reviews = mock("Array of Reviews"))
        reviews.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested review as @review" do
      Review.should_receive(:find).with("37").and_return(mock_review)
      get :show, :id => "37"
      assigns[:review].should equal(mock_review)
    end
    
    describe "with mime type of xml" do

      it "should render the requested review as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Review.should_receive(:find).with("37").and_return(mock_review)
        mock_review.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new review as @review" do
      Review.should_receive(:new).and_return(mock_review)
      get :new
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
        Review.should_receive(:new).with({'these' => 'params'}).and_return(mock_review(:save => true))
        post :create, :review => {:these => 'params'}
        assigns(:review).should equal(mock_review)
      end

      it "should redirect to the created review" do
        Review.stub!(:new).and_return(mock_review(:save => true))
        post :create, :review => {}
        response.should redirect_to(review_url(mock_review))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved review as @review" do
        Review.stub!(:new).with({'these' => 'params'}).and_return(mock_review(:save => false))
        post :create, :review => {:these => 'params'}
        assigns(:review).should equal(mock_review)
      end

      it "should re-render the 'new' template" do
        Review.stub!(:new).and_return(mock_review(:save => false))
        post :create, :review => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested review" do
        Review.should_receive(:find).with("37").and_return(mock_review)
        mock_review.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :review => {:these => 'params'}
      end

      it "should expose the requested review as @review" do
        Review.stub!(:find).and_return(mock_review(:update_attributes => true))
        put :update, :id => "1"
        assigns(:review).should equal(mock_review)
      end

      it "should redirect to the review" do
        Review.stub!(:find).and_return(mock_review(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(review_url(mock_review))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested review" do
        Review.should_receive(:find).with("37").and_return(mock_review)
        mock_review.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :review => {:these => 'params'}
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

    it "should destroy the requested review" do
      Review.should_receive(:find).with("37").and_return(mock_review)
      mock_review.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the reviews list" do
      Review.stub!(:find).and_return(mock_review(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(reviews_url)
    end

  end

end
