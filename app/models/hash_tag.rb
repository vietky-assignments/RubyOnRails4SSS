class HashTag < ActiveRecord::Base
    validates :name, presence: true, length: { minimum: 2 }
    belongs_to :articles, dependent: :destroy
end