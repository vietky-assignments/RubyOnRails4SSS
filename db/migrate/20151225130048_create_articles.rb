class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :file_path
      t.text :description

      t.timestamps null: false
    end
  end
end
