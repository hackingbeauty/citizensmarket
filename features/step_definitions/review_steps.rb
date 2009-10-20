Given /^a review with these attributes:$/ do |table|
  # table is a Cucumber::Ast::Table
  @review = Review.new
  target_status = "preview"
  table.rows_hash.each do |key, value|
    case key
      
    when "user"
      Given %{an activated contributor user named "#{value}"}
      @review.user = @user
      #break
    
    when "company"
      Given %{a company with name "#{value}"}
      @review.company = @company
    
    when "issues"
      issue_names = value.split(/,\s*/)
      issue_names.each do |issue_name|
        Given %{an issue named "#{issue_name}"}
      end
      @review.issues = issue_names.map{|x| Issue.find(:first, :conditions => ["name = ?", x])}
    
    when "status"
      
    when "rating"
      @review.rating = value
    else
      method = @review.method("#{key}=")
      method.call(value)   
    end
  end
  @review.save.should be_true
  #case table.rows_hash["status"]
  #when nil
  #  break
  #when "preview"
  #  break
  #when "draft"
  #  @review.save_as_draft!
  #when "published"
  #  @review.publish!
  #end
end