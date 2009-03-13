class IssueCategory
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def self.all
    Issue.all(:select => :category, :group => :category, :order => :category).map do |issue|
      IssueCategory.new(issue.category)
    end
  end
  
  def issues
    Issue.find_all_by_category(@name)
  end
  
end