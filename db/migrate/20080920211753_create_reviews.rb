class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.text        :body
      t.string      :status, :null => false
      t.references  :company
      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end

