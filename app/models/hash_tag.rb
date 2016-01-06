class HashTag < ActiveRecord::Base
    validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
    has_many :articles, through: :articles_hash_tags_relationships
    has_many :articles_hash_tags_relationships

    def self.create_tags(tags)
        tagNames = []
        tags.split(' ').uniq.each do |tagName|
            tagNames << HashTag.remove_hash_if_not_exist(tagName)
        end
        tagNamesInDb = HashTag.where('name IN (?)', tagNames).pluck('name')
        tagNamesToBeInserted = tagNames - tagNamesInDb

        allTags = []
        tagNamesToBeInserted.each do |tagName|
            tag = HashTag.new(:name => tagName)
            allTags << tag
        end
        HashTag.import allTags, :validate => true

        HashTag.where('name IN (?)', tagNames)
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