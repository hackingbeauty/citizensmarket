class CreatePeerRatings < ActiveRecord::Migration
  def self.up
    create_table :peer_ratings do |t|
      t.integer :review_id
      t.integer :user_id
      t.float :score
      
      t.timestamps
    end
  end

  def self.down
    drop_table :peer_ratings
  end
end
