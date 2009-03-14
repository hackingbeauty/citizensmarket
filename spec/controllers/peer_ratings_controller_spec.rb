require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

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
