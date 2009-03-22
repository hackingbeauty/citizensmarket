class Company < ActiveRecord::Base
  
  has_many  :reviews, :dependent => :destroy
  has_many  :brands
  serialize :info, Hash
  
  validates_presence_of   :name, :on => :create, :message => "can't be blank"
  
  ##########################################################
  ######## SCORING SYSTEM
  
  class << self
    def suggest(name)
      find(:all, :conditions => ["name like ?", name + '%']).map{|record| record.name} if name
    end
  end
  
  def issue_score(issue)
    # return cached if it exists
    
    return nil if reviews.size == 0
    
    numerator = 0
    denominator = 0
    
    reviews_for_issue(issue).each do |r|
      next if r.quality_factor.nil?
      numerator += r.rating * r.non_negative_quality_factor
      denominator += r.non_negative_quality_factor
    end
    
    return nil if denominator == 0

    numerator.to_f / denominator.to_f    
     
  end

  ######## end SCORING SYSTEM
  ##########################################################
  def floor_to(x)
      (self * 10**x).floor.to_f / 10**x
    end
  
  
  def reviews_for_issue(issue)
    Review.find(:all, :include => "issues", :conditions => "reviews.company_id = #{id} and review_issues.issue_id = #{issue.id}")
  end
  
  def total_reviews
    num = Review.find(:all,:conditions => "reviews.company_id = #{id}" )
  end
  
  def brand_names
    brands.map(&:name)
  end
  
  ## dummy placeholder
  def score
    rand(100) / 10.0
  end
  
  
  

  
end


