require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Issue do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :category => "value for category"
    }
  end

  it "should create a new instance given valid attributes" do
    Issue.create!(@valid_attributes)
  end
end
