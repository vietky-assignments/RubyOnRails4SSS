class Article < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :hash_tags
    belongs_to :user
    validates :description, presence: true, length: { minimum: 10 }
    validates :user_id, presence: true

    def add_tags(tags)
        hash_tags.each do |tag|
            tag.destroy
        end

        tags.split(' ').each do |tag|
            hash_tags.new(:name => remove_hash_if_not_exist(tag))
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
    
    def remove_hash_if_not_exist(tag)
        if tag.length < 1
            return tag
        else
            if tag.start_with?('#')
                return tag[1,tag.length]
            end
        end
    end
end
