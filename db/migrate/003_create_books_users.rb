class CreateBooksUsers < ActiveRecord::Migration
  def self.up
    create_table :books_users, :id => false do |t|
      t.references :book
      t.references :user
      t.timestamps      
    end
  end

  def self.down
    drop_table :books_users
  end
end
