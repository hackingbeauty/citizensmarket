require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReviewIssue do
  before(:each) do
    @valid_attributes = {
      :review_id => 1,
      :issue_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    ReviewIssue.create!(@valid_attributes)
  end
end
