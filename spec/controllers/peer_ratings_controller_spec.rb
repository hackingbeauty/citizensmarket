require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PeerRatingsController do

  def mock_peer_rating(stubs={})
    @mock_peer_rating ||= mock_model(PeerRating, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all peer_ratings as @peer_ratings" do
      PeerRating.should_receive(:find).with(:all).and_return([mock_peer_rating])
      get :index
      assigns[:peer_ratings].should == [mock_peer_rating]
    end

    describe "with mime type of xml" do
  
      it "should render all peer_ratings as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        PeerRating.should_receive(:find).with(:all).and_return(peer_ratings = mock("Array of PeerRatings"))
        peer_ratings.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested peer_rating as @peer_rating" do
      PeerRating.should_receive(:find).with("37").and_return(mock_peer_rating)
      get :show, :id => "37"
      assigns[:peer_rating].should equal(mock_peer_rating)
    end
    
    describe "with mime type of xml" do

      it "should render the requested peer_rating as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        PeerRating.should_receive(:find).with("37").and_return(mock_peer_rating)
        mock_peer_rating.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new peer_rating as @peer_rating" do
      PeerRating.should_receive(:new).and_return(mock_peer_rating)
      get :new
      assigns[:peer_rating].should equal(mock_peer_rating)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested peer_rating as @peer_rating" do
      PeerRating.should_receive(:find).with("37").and_return(mock_peer_rating)
      get :edit, :id => "37"
      assigns[:peer_rating].should equal(mock_peer_rating)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created peer_rating as @peer_rating" do
        PeerRating.should_receive(:new).with({'these' => 'params'}).and_return(mock_peer_rating(:save => true))
        post :create, :peer_rating => {:these => 'params'}
        assigns(:peer_rating).should equal(mock_peer_rating)
      end

      it "should redirect to the created peer_rating" do
        PeerRating.stub!(:new).and_return(mock_peer_rating(:save => true))
        post :create, :peer_rating => {}
        response.should redirect_to(peer_rating_url(mock_peer_rating))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved peer_rating as @peer_rating" do
        PeerRating.stub!(:new).with({'these' => 'params'}).and_return(mock_peer_rating(:save => false))
        post :create, :peer_rating => {:these => 'params'}
        assigns(:peer_rating).should equal(mock_peer_rating)
      end

      it "should re-render the 'new' template" do
        PeerRating.stub!(:new).and_return(mock_peer_rating(:save => false))
        post :create, :peer_rating => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested peer_rating" do
        PeerRating.should_receive(:find).with("37").and_return(mock_peer_rating)
        mock_peer_rating.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :peer_rating => {:these => 'params'}
      end

      it "should expose the requested peer_rating as @peer_rating" do
        PeerRating.stub!(:find).and_return(mock_peer_rating(:update_attributes => true))
        put :update, :id => "1"
        assigns(:peer_rating).should equal(mock_peer_rating)
      end

      it "should redirect to the peer_rating" do
        PeerRating.stub!(:find).and_return(mock_peer_rating(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(peer_rating_url(mock_peer_rating))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested peer_rating" do
        PeerRating.should_receive(:find).with("37").and_return(mock_peer_rating)
        mock_peer_rating.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :peer_rating => {:these => 'params'}
      end

      it "should expose the peer_rating as @peer_rating" do
        PeerRating.stub!(:find).and_return(mock_peer_rating(:update_attributes => false))
        put :update, :id => "1"
        assigns(:peer_rating).should equal(mock_peer_rating)
      end

      it "should re-render the 'edit' template" do
        PeerRating.stub!(:find).and_return(mock_peer_rating(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested peer_rating" do
      PeerRating.should_receive(:find).with("37").and_return(mock_peer_rating)
      mock_peer_rating.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the peer_ratings list" do
      PeerRating.stub!(:find).and_return(mock_peer_rating(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(peer_ratings_url)
    end

  end

end
