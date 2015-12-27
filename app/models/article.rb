class Article < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    has_many :hash_tags
    belongs_to :user
    validates :description, presence: true, length: { minimum: 10 }
    validates :user_id, presence: true
    
    def add_tags(hash_tags)
    end

end
