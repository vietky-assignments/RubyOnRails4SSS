class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :articles, :dependent => :destroy
    has_many :comments, :dependent => :destroy

    has_many :users_relationships, :dependent => :destroy, :foreign_key => 'follower_id'
    has_many :following, :through => :users_relationships, :source => :followed

    has_many :reverse_users_relationships, :dependent => :destroy, :foreign_key => 'followed_id'
    has_many :followers, :through => :reverse_users_relationships, :source => :follower

    def feed
        Article.from_users_followed_by(self)
    end

    def following?(followed)
        users_relationships.find_by_followed_id(followed)
    end

    def follow!(followed)
        users_relationships.create!(:followed => followed)
    end

    def unfollow!(followed)
        users_relationships.find_by_followed_id(followed).destroy
    end
end
