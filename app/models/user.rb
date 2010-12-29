class User < ActiveRecord::Base
  has_many :user
  has_many :authentications
  has_many :trails
  has_one  :setting

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def current_trail
    trails.find(setting.current_trail_id)
  end

  def sorted_trails
    trails.order("column_id, sort_index")
  end

  
  # This shouldn't be necessary. 
  def feeds
    Feed.where(:user_id=>id).order("sort_order asc")
    # Feed.order("order asc")
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
