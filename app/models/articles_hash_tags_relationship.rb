class ArticlesHashTagsRelationship < ActiveRecord::Base
    belongs_to :article, dependent: :destroy
    belongs_to :hash_tag, dependent: :destroy
end
