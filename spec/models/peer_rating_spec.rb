require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PeerRating do
  before(:each) do
    @user = mock_model(User, :valid? => true)
    @review = mock_model(Review, :valid? => true)

    @valid_attributes = {
      :score => "1",
      :user => @user,
      :review => @review
    }
  end

  it "should create a new instance given valid attributes" do
    PeerRating.create!(@valid_attributes)
  end
end
