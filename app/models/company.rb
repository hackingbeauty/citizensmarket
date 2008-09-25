class Company < ActiveRecord::Base
  
  has_many  :reviews, :dependent => :destroy
  
  validates_presence_of   :name, :on => :create, :message => "can't be blank"
  
  # Temporary method that outputs a randomly sized array of brands for view purposes
  def brands
    brands = ["Axe", "Dove", "Lux", "Pond's", "Sunsilk", "Vasoline", "Clif", "Comfort", "Sunlight", "Surf"]
    brands[0, rand(9)+1]
  end
  
  def score
    rand(100) / 10.0
  end
  

  
end


