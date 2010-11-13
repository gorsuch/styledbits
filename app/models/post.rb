class Post < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  validates_presence_of :account
  validates_presence_of :user
  validates_presence_of :body
end
