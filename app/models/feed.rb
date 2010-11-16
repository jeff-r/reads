class Feed < ActiveRecord::Base
  has_many :feed_items
  
  def most_recent_item_time
    if feed_items.count == 0
      return DateTime.parse "01-01-1970"
    end
    lasttime = feed_items.order("pub_date").last.pub_date
  end
end
