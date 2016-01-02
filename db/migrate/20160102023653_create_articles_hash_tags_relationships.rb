class CreateArticlesHashTagsRelationships < ActiveRecord::Migration
  def change
    create_table :articles_hash_tags_relationships do |t|
      t.integer :article_id
      t.integer :hash_tag_id

      t.timestamps null: false
    end
      
      add_foreign_key :articles_hash_tags_relationships, :hash_tags
      add_foreign_key :articles_hash_tags_relationships, :articles

      add_index :articles_hash_tags_relationships, [:article_id, :hash_tag_id], :unique => true, :name => 'index_articles_hash_tags_rels_on_article_id_and_hash_tag_id'
      add_index :articles_hash_tags_relationships, :article_id
      add_index :articles_hash_tags_relationships, :hash_tag_id
  end
end
