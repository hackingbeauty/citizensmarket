require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/reviews/edit.html.erb" do

  before(:each) do
    assigns[:review] = @user = stub_model(Review,
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

  it "should render edit form" do
    render "/reviews/edit.html.erb"
    
    response.should have_tag("form[action=#{review_path(@review)}][method=post]") do
      with_tag('select#company_picker_id[name=?]', "company_picker_id")
      with_tag("input[name='star']")
      with_tag("input#review_rating[name='review[rating]']")
      with_tag('textarea#review_body[name=?]', "review[body]")
    end
  end
end


