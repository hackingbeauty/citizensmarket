Given /^a review with these attributes:$/ do |table|
  # table is a Cucumber::Ast::Table
  @review = typical_review(table.rows_hash)
  
  @review.valid?
  @review.save.should be_true
  
end

Given /^a typical draft review/ do
  @review = typical_review
  @review.status = "draft"
  @review.save.should be_true
end

Given /^a typical published review/ do
  @review = typical_review
  @review.status = "published"
  @review.save.should be_true
end

def typical_issue
  @issue ||= Issue.create!(:name => "typical issue name", :category => "typical issue category", :description => "typical issue descriptioin")
end

def typical_review(custom_params = {})
  
  @review = Review.new(default_review_params)
  
  @review.user = user_named(custom_params["user"]) if custom_params.has_key?("user")
  @review.company = company_named(custom_params["company"]) if custom_params.has_key?("company")
  if custom_params.has_key?("issues")
    @review.issues = []
    custom_params["issues"].split(/\s*,\s*/).map{|x| issue_named(x)}.each do |issue|
      @review.issues << issue
    end
  end
  
  @review.body = custom_params["body"] || @review.body
  @review.rating = custom_params["rating"] || @review.rating
  
  @review
end

def next_company
  
  @company = Factory(:company)#Company.find(:first, :conditions => ["id > ?", @last_company_id || 0]) # replaced this find with a factory, was crashing otherwise
  @company.should_not be_nil
  @last_company_id = @company.id
  @company
end


def default_review_params
  company = next_company
  {
    "company" => company,
    "user" => @user || create_user,
    "body" => "typical review body",
    "issues" => [],# [Issue.find_by_name("hunger")] removed this since 1) it wasn't being tested for, and 2) it was crashing since there is no issue called hunger,
    "rating" => 1,
  }
end