require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe CmScores do
  fixtures :companies
  fixtures :reviews
  fixtures :users
  fixtures :peer_ratings
  fixtures :issues
  
  describe "cacheing" do
    
    before(:each) do
      
      CACHE.flush_all
          
    end
    
    it "should cache a generic_company_score" do
      company = Company.find(1)
      CACHE.get("CmScores.generic_company_score(company_id=1)").should be_nil
      result = CmScores.generic_company_score(company)
      CACHE.get("CmScores.generic_company_score(company_id=1)").should == result
    end
    
    it "should cache a review_score" do
      review = Review.find(1)
      CACHE.get("CmScores.review_score(review_id=1)").should be_nil
      result = CmScores.review_score(review)
      CACHE.get("CmScores.review_score(review_id=1)").should == result
    end
    
    it "should cache user_contributor_level" do
      user = User.find(1)
      CACHE.get("CmScores.user_contributor_level(user_id=1)").should be_nil
      result = CmScores.user_contributor_level(user)
      CACHE.get("CmScores.user_contributor_level(user_id=1)").should == result
    end
    
    
  end
  
  
end