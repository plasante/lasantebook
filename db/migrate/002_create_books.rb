class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.references :user
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
  end

  def self.down
    drop_table :books
  end
end
