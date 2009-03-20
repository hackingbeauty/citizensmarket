class Issue < ActiveRecord::Base
  
  has_many    :review_issues
  has_many    :reviews, :through => :review_issues
  has_many    :user_issues
  
  # Scopes all issues within a given category
  # i.e. - Issue.issues_in_category "Society"
  named_scope :issues_in_category, lambda { |*args| {:conditions => {:category => args.first}}}
  
  def name_with_category
    "#{category} - #{name}"
  end
  
  #Returns an array of categories
  # i.e. - ["Economic Development", "Environment", ...]
  def self.categories
    @categories ||= all(:select => :category, :group => :category, :order => :category).map(&:category)
  end
    
  # Returns a hash with the issue category as the key and an array of issue names as the value.
  # Useful for rendering a grouped list of issues.
  # i.e. - {"Environment" => ["Conservation", "Biodiversity", ...], ...}
  def self.by_category
    categories.inject({}) do |by_category, category|
      by_category[category] = Issue.issues_in_category(category).map(&:name)
      by_category
    end
  end
  
end
