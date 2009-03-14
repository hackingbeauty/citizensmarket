class CreateBrands < ActiveRecord::Migration
  def self.up
    create_table :brands do |t|
      t.text        :name
      t.string      :description
      t.references  :company
      t.timestamps
    end
  end

  def self.down
    drop_table :brands
  end
end
