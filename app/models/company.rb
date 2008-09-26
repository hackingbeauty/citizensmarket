class Company < ActiveRecord::Base
  
  has_many  :reviews, :dependent => :destroy
  has_many  :brands
  
  validates_presence_of   :name, :on => :create, :message => "can't be blank"
  
  def brand_names
    brands.map(&:name)
  end
  
  def score
    rand(100) / 10.0
  end
  

  
end


