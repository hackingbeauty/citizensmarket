require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reviews/edit.html.erb" do

  before(:each) do
    assigns[:review] = @review = stub_model(Review,
      :new_record? => false,
      :body => "value for body",
      :status => "value for status",
      :company_id => 1,
      :user_id => 1
    )
  
    @controller.instance_variable_set(:@url, (ActionController::UrlRewriter.new @request, {}))
    
    template.stub!(:new_object_url).and_return(new_review_path())
    template.stub!(:edit_object_url).and_return(edit_review_path(@review))
    
  end

  it "should be able to render edit.html.erb" do
    render "/reviews/edit.html.erb"
    response.should have_tag("h1")
  end

  it "should render a form" do
    render "/reviews/edit.html.erb"
    response.should have_tag("form")
  end

  it "should render edit form" do
    render "/reviews/edit.html.erb"  
    response.should have_tag("form[method=post][action$=/reviews/#{@review.id}]") do
      with_tag('textarea#review_body[name=?]', "review[body]")
    end
  end
  
  it "should include the star rating system" do
    render "/reviews/edit.html.erb"
    response.should have_tag("select#review_rating")
  end
  
end


