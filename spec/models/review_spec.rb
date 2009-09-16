require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Review do
  before(:each) do
    @user = Factory.build(:user, :terms_of_use => "1")
    @user.stub!(:activate)
    @user.save
    @company = Factory(:company)
  end
  
  it "should create a new instance given valid attributes" do
    review1 = @user.reviews.create(Factory.attributes_for(:review, :company => @company)).should be_true
  end
  
  it "should not allow a user User to submit no more than one Review per Company-Issue pair per 180 days." do
    review1 = @user.reviews.create(Factory.attributes_for(:review, :company => @company))
    review2 = Factory.build(:review, :user => @user, :company => @company)
    review2.user = @user
    review2.save.should be_false
  end
  
end
