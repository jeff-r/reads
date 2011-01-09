class Page < ActiveRecord::Base
  has_many :trails
  belongs_to :user

end
