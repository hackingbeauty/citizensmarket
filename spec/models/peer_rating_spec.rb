require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PeerRating do
  before(:each) do
    @user = mock_model(User, :valid? => true)
    @review = mock_model(Review, :user => mock_model(User, :valid? => true), :valid? => true)
  end

  it "should create a new instance given valid attributes" do
    PeerRating.create!(valid_attributes)
  end
  
  it "should not allow a user to submit more than one Peer Rating per Review" do 
    pr1 = PeerRating.create(valid_attributes)
    pr1.should be_valid
    PeerRating.create(valid_attributes).should_not be_valid
  end
  
  it "should not allow a user to submit a Peer Rating for any of his/her Reviews" do
    @review = Factory(:review, :user => @user)
    PeerRating.create(valid_attributes).valid?.should be_false
  end
  
  private
  
  def valid_attributes
    @valid_attributes = {
      :score => "1",
      :user => @user,
      :review => @review
    }
  end
end
