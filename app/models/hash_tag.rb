class HashTag < ActiveRecord::Base
    validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
    has_many :articles, through: :articles_hash_tags_relationships
    has_many :articles_hash_tags_relationships
end