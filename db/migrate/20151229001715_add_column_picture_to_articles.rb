class AddColumnPictureToArticles < ActiveRecord::Migration
  def change
      add_column :articles, :picture, :string
      remove_column :articles, :file_path, :string
  end
end
