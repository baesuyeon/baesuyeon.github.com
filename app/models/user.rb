class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # user(방장)과 프로젝트
  has_many :projects
  
  has_many :likes
  
  has_many :liked_projects, through: :likes, source: :project
  
  def is_like?(project)
    Like.find_by(user_id: self.id, project_id: project.id).present?
  end
end
