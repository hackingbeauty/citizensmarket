class Headquarter < ActiveRecord::Base
  belongs_to :company

  validates_presence_of :address

  validates_presence_of :city
  validates_format_of :city, :with => /^[^\d]+$/, :message => "numbers are not allowed in the city name"

  validates_presence_of :state
  validates_format_of :state, :with => /^[a-z]{2}$/i, :message => "states are"

  validates_presence_of :zipcode
  validates_format_of :zipcode, :with => /^[0-9]{5}$/, :message => "must be a five digit number"
end

