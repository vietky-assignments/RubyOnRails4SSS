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
    scope :from_users_followed_by, -> (user) { followed_by(user) }

    def self.search(tag)
        tag = HashTag.remove_hash_if_not_exist(tag)
        Article.where(:id =>
            ArticlesHashTagsRelationship
                .where(:hash_tag_id => HashTag.where("name like ?", "%#{tag}%"))
                .select("article_id")
        )
    end

    def create_tags_and_relationships(tags)
        article = self;
        tags = HashTag.create_tags(tags)
        if tags.empty?
            false
        end
        ArticlesHashTagsRelationship.create_relationships(article, tags)
    end

    private
    
    def self.followed_by(user)
        following_ids = "SELECT followed_id FROM users_relationships WHERE follower_id = :user_id"
        where("user_id = :user_id OR (user_id IN (#{following_ids}))", :user_id => user)
    end

    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end
    end
end
