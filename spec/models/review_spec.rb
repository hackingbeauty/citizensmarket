require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Review do
  before(:each) do
    @valid_attributes = {
      :body => "value for body",
      :status => "value for status"
    }
  end

  it "should create a new instance given valid attributes" do
    Review.create!(@valid_attributes)
  end
end
