require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Company do
  before(:each) do
    @company = Company.new
    @valid_attributes = {
      :name => "Proctor & Gamble"
    }
  end

  it "should create a new instance given valid attributes" do
    Company.create!(@valid_attributes)
  end
  
  # Validations
  it "should validate the presence of name" do
    @company.attributes = @valid_attributes.except(:name)
    @company.should have(1).error_on(:name)
  end
  
  
end

describe Company, " Suggest and Lookup" do
  fixtures :companies
  before do
    @company = Company.find_by_name("Apple Inc.")
  end
  
  it "should suggest a company name" do
    Company.suggest('Apple').should include("Apple Inc.")
  end
  
  it "should populate name" do
    @company.name.should eql("Apple Inc.")
  end
  
  it "should populate stock_symbol" do
    @company.stock_symbol.should eql("NASDAQ:AAPL")
  end
  
  it "should populate description" do
    @company.description.should include_text("iPod")
  end
  
  it "should populate logo_url" do
    @company.logo_url.should match(/http:\/\/.+\.(gif|jpg|png)/i)
  end
  
  it "should populate website_url" do
    @company.website_url.should match(/https?:\/\/.+/i)
  end
  
  it "should populate google_cid" do
    @company.google_cid.should eql(22144)
  end
  
end