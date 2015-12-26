class Article < ActiveRecord::Base
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :description, presence: true, length: { minimum: 10 }
    validates :user_id, presence: true
end
