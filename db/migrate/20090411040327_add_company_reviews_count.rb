class AddCompanyReviewsCount < ActiveRecord::Migration
  def self.up
    add_column :companies, :reviews_count, :integer, :default => 0
    Company.find(:all).each do |c|
      c.reviews_count = c.reviews.count
      c.save!
    end
  end

  def self.down
    remove_column :companies, :reviews_count
  end
end
