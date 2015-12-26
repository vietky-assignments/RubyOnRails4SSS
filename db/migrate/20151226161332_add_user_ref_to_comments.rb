class AddUserRefToComments < ActiveRecord::Migration
  def change
      add_foreign_key :comments, :users
      add_index :comments, :user_id
  end
end