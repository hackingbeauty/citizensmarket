require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe PeerRatingsController, "POST create" do
  
  before(:each) do
    @peer_rating = mock_model(PeerRating, :save => nil)
    PeerRating.stub!(:new).and_return(@peer_rating)
    login_as(mock_user)
    User.should_receive(:find).at_most(10).times.and_return(mock_user)
  end
  
  it "should build a new peer_rating" do
    PeerRating.should_receive(:new).with("review_id" => "1", "score" => "1", "user_id" => "1").and_return(@peer_rating)
    post :create, :peer_rating => {"review_id" => "1", "score" => "1"}
  end
  it "should save the peer_rating" do 
    @peer_rating.should_receive(:save)
    post :create, :peer_rating => {}
  end
  
  context "when the peer_rating saves successfully" do
    before(:each) do
      @peer_rating.stub!(:save).and_return true
    end
    it "should render a confirmation" do
      post :create
      response.should render_template('_feedback_given')
    end
  end
  context "when the peer_rating fails to save" do
    before(:each) do
      @peer_rating.stub!(:save).and_return false
    end
    it "should render an error indicator" do
      post :create
      response.should render_template('_feedback_failed')
    end
  end
  
end

# these functions are for controller functions names "vote up" and "vote_down", which are not restful

describe PeerRatingsController do

  def mock_peer_rating(stubs={})
    @mock_peer_rating ||= mock_model(PeerRating, stubs)
  end
  
  def mock_review(stubs={})
    @mock_review ||= mock_model(Review, stubs)
  end
  
  describe "responding to vote up" do

    it "should create a new peer rating with up value" do
      Review.should_receive(:find).with("1").and_return(mock_review)
      mock_peer_rating.stub!(:save!)
      PeerRating.should_receive(:new).and_return(mock_peer_rating)
      get :vote_up, :review_id => "1"
      response.should be_success
    end

  end

  describe "responding to vote down" do

    it "should create a new peer rating with down value" do
      Review.should_receive(:find).with("1").and_return(mock_review)
      PeerRating.should_receive(:new).and_return(mock_peer_rating)
      mock_peer_rating.stub!(:save!)
      get :vote_up, :review_id => "1"
      response.should be_success
    end
  end

end
