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
    review1 = Factory.build(:review, :user => @user, :company => @company)
    review1.save.should be_true
    review2 = Factory.build(:review, :user => @user, :company => @company)
    review2.save.should be_false
  end
  
  it "should take update_attributes(:aasm_event => 'publish') and publish the review" do
    review = @user.reviews.create(Factory.attributes_for(:review, :company => @company)).should be_true
    review.status.should == "draft"
    review_id = review.id
    review = Review.find(review_id)
    review.update_attributes(:aasm_event => "publish").should be_true
    review = Review.find(review_id)
    review.status.should == "published"
  end
  
  it "should NOT accept 0.5 as a valid rating" do
    review = @user.reviews.create(Factory.attributes_for(:review, :company => @company, :rating => 0.5)).should be_true
    review.should_not be_valid
  end
  
end
