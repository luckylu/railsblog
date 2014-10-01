class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: { minimum: 2 }
  before_save :set_first_user_admin

  private 
  def set_first_user_admin
  	if User.all.size == 0
  		self.admin = true
  	end
  end
  
end
