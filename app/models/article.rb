class Article < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :hash_tags
    belongs_to :user
    validates :description, presence: true, length: { minimum: 10 }
    validates :user_id, presence: true

    def self.search(tag)
        tag = '%'+remove_hash_if_not_exist(tag)+'%'
        where('id IN (SELECT article_id FROM hash_tags WHERE (name like :tag))', :tag => tag)
    end

    def add_tags(tags)
        if hash_tags
            hash_tags.each do |tag|
                tag.destroy
            end
        end

        tags.split(' ').each do |tag|
            hash_tags.new(:name => self.class.remove_hash_if_not_exist(tag))
        end
    end
    
    def import_tags(tags)
        htags = []
        tags.split(' ').each do |tag|
            htags << HashTag.new(:article_id => self.id, :name => tag)
        end
        HashTag.import htags
    end
    
    private
    
    def self.remove_hash_if_not_exist(tag)
        if tag.start_with?('#')
            if tag.length > 1
                return tag[1,tag.length]
            end
        end
        return tag
    end
end
