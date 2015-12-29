require 'active_record'
require 'activerecord-import'

class Article < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :hash_tags
    belongs_to :user
    mount_uploader :picture, PictureUploader
    validates :description, presence: true, length: { minimum: 10 }
    validates :user_id, presence: true
    validate  :picture_size
    default_scope { order('articles.updated_at DESC') }
    #default_scope :order => 'article.updated_at DESC'

    def self.search(tag)
        tag = remove_hash_if_not_exist(tag)
        where(:id => HashTag.where("name like ?", "%#{tag}%").select("article_id"))
    end

    def add_tags(tags)
        #TODO: need transaction here
        HashTag.delete_all(:article_id => id)

        htags = []
        tags.split(' ').uniq.each do |tag|
            htags << HashTag.new(:article_id => self.id, :name => self.class.remove_hash_if_not_exist(tag))
        end
        HashTag.import htags

        #tags.split(' ').each do |tag|
        #    hash_tags.new(:name => self.class.remove_hash_if_not_exist(tag))
        #end
    end
    
    private
    
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end
    end

    def self.remove_hash_if_not_exist(tag)
        if tag.start_with?('#')
            if tag.length > 1
                return tag[1,tag.length]
            end
        end
        return tag
    end
end
