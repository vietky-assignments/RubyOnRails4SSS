require 'active_record'
require 'activerecord-import'

class Article < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :articles_hash_tags_relationships
    has_many :hash_tags, through: :articles_hash_tags_relationships

    belongs_to :user
    mount_uploader :picture, PictureUploader
    validates :description, presence: true, length: { minimum: 10 }
    validates :user_id, presence: true
    validate  :picture_size
    default_scope { order('articles.updated_at DESC') }
    #default_scope :order => 'article.updated_at DESC'

    def self.search(tag)
        tag = HashTag.remove_hash_if_not_exist(tag)
        Article.where(:id => ArticlesHashTagsRelationship.where(:hash_tag_id => HashTag.where("name like ?", "%#{tag}%")).select("article_id"))
        .includes('hash_tags')
        .includes('user')
    end

    private
    
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end
    end
end
