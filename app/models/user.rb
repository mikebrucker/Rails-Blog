class User < ApplicationRecord
    has_many :posts
    has_many :comments

    validates_presence_of :username, :email, :password
    validates_uniqueness_of :username, :email, :case_sensitive => false
    validates :username, length: {in: 4..20}
    validates :password, length: {in: 8..56}
end
