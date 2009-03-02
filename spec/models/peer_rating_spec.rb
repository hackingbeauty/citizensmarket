require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PeerRating do
  before(:each) do
    @valid_attributes = {
      :review_id => "1",
      :user_id => "1",
      :score => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    PeerRating.create!(@valid_attributes)
  end
end
