class HashTag < ActiveRecord::Base
    validates :name, presence: true, length: { minimum: 3 }
    belongs_to :articles, dependent: :destroy
end