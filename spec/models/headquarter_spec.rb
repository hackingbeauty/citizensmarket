require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Headquarter do
  before(:each) do
    @headquarter = Headquarter.new
    @valid_attributes = {
      :address => "1234 Any St.",
      :city => "Anytown",
      :state => "ID",
      :zipcode => "12345"
    }
  end

  it "should create a new instance given valid attributes" do
    Headquarter.create!(@valid_attributes)
  end
  
  # Validations
  describe "Zipcode" do
    it "should validate the presence of zipcode" do
      @headquarter.attributes = @valid_attributes.except(:zipcode)
      @headquarter.should have(2).error_on(:zipcode)
    end
  
    it  "should require a valid zipcode" do
      @headquarter.attributes = @valid_attributes.except(:zipcode)
      @headquarter.zipcode = "My invalid zip"
      @headquarter.should have(1).error_on(:zipcode)
    end
  end
  describe "Address" do
    it "should validate the presence of address" do
      @headquarter.attributes = @valid_attributes.except(:address)
      @headquarter.should have(1).error_on(:address)
    end
  
    it  "should require a valid address" do
      @headquarter.attributes = @valid_attributes.except(:address)
      @headquarter.address = "My valid address" #Setting the address
      @headquarter.should have(0).error_on(:address)
    end
  end
  describe "City" do
    it "should validate the presence of city" do
      @headquarter.attributes = @valid_attributes.except(:city)
      @headquarter.should have(2).error_on(:city)
    end
  
    it  "should require a valid city" do
      @headquarter.attributes = @valid_attributes.except(:city)
      @headquarter.city = "2 cities"
      @headquarter.should have(1).error_on(:city)
    end
  end
  describe "State" do
    it "should validate the presence of state" do
      @headquarter.attributes = @valid_attributes.except(:state)
      @headquarter.should have(2).error_on(:state)
    end
  
    it  "should require a valid state" do
      @headquarter.attributes = @valid_attributes.except(:state)
      @headquarter.state = "2 state"
      @headquarter.should have(1).error_on(:state)
    end
  end
   
end

