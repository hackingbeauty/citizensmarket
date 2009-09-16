class Company < ActiveRecord::Base
  
  has_many  :reviews, :dependent => :destroy
  has_many  :brands
  has_many  :headquarters, :dependent => :destroy
  serialize :info, Hash
  
  validates_presence_of   :name, :on => :create, :message => "can't be blank"
  
  ##########################################################
  ######## SCORING SYSTEM
  
  # moved to lib/cm_scores.rb - Luke
  
  ######## end SCORING SYSTEM
  ##########################################################
  
  class << self
    def suggest(name)
      find(:all, :conditions => ["name like ?", name + '%']).map{|record| record.name} if name
    end
  end
  
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


