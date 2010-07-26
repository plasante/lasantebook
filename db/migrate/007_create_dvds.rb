class CreateDvds < ActiveRecord::Migration
  def self.up
    create_table :dvds do |t|
      t.string :title
      t.string :author
      t.date :release_date
      t.text :description
      t.string :image_url_small
      t.string :image_url_medium
      t.string :image_url_large
      t.string :amazon_url
      t.string :isbn
      t.timestamps
    end
    
    create_table :dvds_users, :id => false do |t|
      t.references :dvd
      t.references :user
      t.timestamps      
    end
    
  end

  def self.down
    drop_table :dvds
    drop_table :dvds_users
  end
end
