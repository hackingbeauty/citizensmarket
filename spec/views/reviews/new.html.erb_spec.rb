require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reviews/new.html.erb" do
  
  before(:each) do
    assigns[:review] = stub_model(Review,
      :new_record? => true,
      :body => "value for body",
      :status => "value for status"
    )
    @controller.instance_variable_set(:@url, (ActionController::UrlRewriter.new @request, {}))
    template.stub!(:collection_url).and_return(reviews_path)
    
  end

  it "should render new form" do
    render "/reviews/new.html.erb"
    response.should have_tag("form[action=?][method=post]", reviews_path) do
      #with_tag('select#company_picker_id[name=?]', "company_picker_id")
      with_tag('textarea#review_body[name=?]', "review[body]")
    end
  end
  
  it "should include the star rating system" do
    render "/reviews/new.html.erb"
    response.should have_tag("select#review_rating")
  end
end


