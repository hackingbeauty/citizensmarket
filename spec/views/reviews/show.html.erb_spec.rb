require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reviews/show.html.erb" do
  
  before(:each) do
    user = stub_model(User, :id => 1)
    company = stub_model(Company, :name => "CompanyName")
    review = Review.create!(Factory.attributes_for(:review, :user => user, :company => company))
    review.save
    assigns[:review] = review
    @controller.instance_variable_set(:@url, (ActionController::UrlRewriter.new @request, {}))
    
    #template.stub!(:edit_object_url).and_return(edit_review_path(@review))
    template.stub!(:collection_url).and_return(reviews_path)

  end

  it "should render attributes in <p>" do
    render "/reviews/show.html.erb"
    response.should have_text(Regexp.compile(Factory.attributes_for(:review)[:body]))
  end
end

