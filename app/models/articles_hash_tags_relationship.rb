class ArticlesHashTagsRelationship < ActiveRecord::Base
    belongs_to :article, dependent: :destroy
    belongs_to :hash_tag, dependent: :destroy

    def self.create_relationships(article, tags)
        articlesHashtagsRels = []
        tags.each do |tag|
            articlesHashtagsRels << ArticlesHashTagsRelationship.new(:article_id => article.id, :hash_tag_id => tag.id)
        end
        ArticlesHashTagsRelationship.delete_all(:article_id => article.id)
        ArticlesHashTagsRelationship.import articlesHashtagsRels

        articlesHashtagsRels
    end
end
