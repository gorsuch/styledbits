class User < ActiveRecord::Base
  belongs_to :account
  has_many :posts
end
