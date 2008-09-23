class Issue < ActiveRecord::Base
  
  has_many    :review_issues
  has_many    :reviews, :through => :review_issues
  
  def name_with_category
    "#{category} - #{name}"
  end
  
end
