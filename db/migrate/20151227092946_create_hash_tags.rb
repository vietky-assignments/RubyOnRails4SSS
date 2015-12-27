class CreateHashTags < ActiveRecord::Migration
  def change
    create_table :hash_tags do |t|
      t.string :name
      t.integer :article_id

      t.timestamps null: false
    end
      
      add_index :hash_tags, [:article_id, :name]
      add_foreign_key :hash_tags, :articles
  end
end
