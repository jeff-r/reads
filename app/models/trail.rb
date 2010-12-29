class Trail < ActiveRecord::Base
  has_many :links
  belongs_to :user

  def column
    self.column_id ||= 0
  end
  def column= val
    self.column_id = val
  end
end
