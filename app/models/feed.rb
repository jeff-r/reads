class Feed < ActiveRecord::Base
  has_many :feed_items
  belongs_to :user
  
  def num_unread_posts
    # feed_items.where(:read => false).count
    # All feed items are initialized with :read => false, so we don't need to check for null
    # But we've got some null values in the db.
    # Once they are marked as read, we can use the above line rather than the next
    FeedItem.where("feed_id = #{id} and (read is 'false' or read is null)").count
  end

  def most_recent_item_time
    if feed_items.count == 0
      return DateTime.parse "01-01-1970"
    end
    lasttime = feed_items.order("pub_date").last.pub_date.strftime("%m/%d/%Y at %I:%M %p")
  end

  def top_level_items
      if defined? @item_title
        items = feed_items.where({:read=>false, :title=>@item_title}).order(:pub_date)
        # logger.debug "log: items: " + items.inspect
        items
      else
        items = feed_items.where(:read=>false).order(:pub_date)

      # Loop through the items, counting the thread titles, and collecting the top-level elements
      top_elements = []
      counts = {}
      items.each do |item| 
        title = item.title
        logger.debug "log:          " + title
        if not counts.has_key? title
          logger.debug "log: adding " + title
          top_elements << item
          counts[title] = 1
        else
          counts[title] += 1
        end
      end
      logger.debug "log: count: " + top_elements.count.to_s
      # now loop through again, setting the counts
      top_elements.each do |element|
        element.num_threadentries = counts[element.title]
      end


      logger.debug "log: count: " + top_elements.count.to_s

      # and return the top level elements
      top_elements
      end
  end

  def subfeed_by_title title
    @item_title = title
    # items = top_level_items.where(:title=>title)
    # # items = feed_items.where(:title=>title)
    # items.each do |item|
    #   item.num_threadentries = 0
    # end
    # @subfeed = items
  end

  def subfeed_or_feed
    feed_items
    # if defined? @subfeed
    #   @subfeed
    # else
    #   feed_items
    # end
  end
end
