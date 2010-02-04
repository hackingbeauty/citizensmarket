class Issue < ActiveRecord::Base

  has_many    :review_issues
  has_many    :reviews, :through => :review_issues
  has_many    :user_issues

  validates_presence_of :name, :description, :category
  validates_uniqueness_of :name, :scope => :category

  # Scopes all issues within a given category
  # i.e. - Issue.issues_in_category "Society"
  named_scope :issues_in_category, lambda { |*args| {:conditions => {:category => args.first}}}

  def name_with_category
    "#{category} - #{name}"
  end

  #Returns an array of categories
  # i.e. - ["Economic Development", "Environment", ...]
  def self.categories
    @categories ||= all(:select => :category, :order => :category).map(&:category)
  end

  # Returns a hash with the issue category as the key and an array of issue names as the value.
  # Useful for rendering a grouped list of issues.
  # i.e. - {"Environment" => ["Conservation", "Biodiversity", ...], ...}
  # a slicker way would be to inject(Hash.new{|h, k| h[k] = []}) and it would save one line of code
  # I am not doing it for better readability. :Diego

  def self.by_category
    @by_category ||= all(:select => "category, name", :order => "category").inject({}) do |result, record|
      result[record.category] ||= []
      result[record.category] << record.name;
      result
    end
  end

end
