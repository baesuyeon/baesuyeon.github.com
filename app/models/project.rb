class Project < ActiveRecord::Base
  belongs_to :user
  has_many :jobs
  has_many :likes
  
  mount_uploader :image, ImageUploader
  
  #특정글에 좋아요 한 users를 알 수 있다.
  has_many :liked_users, through: :likes, source: :user
end
