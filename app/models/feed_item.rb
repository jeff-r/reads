class FeedItem < ActiveRecord::Base
  belongs_to :feed

  def has_sub_items?
    if not num_threadentries.nil?
      num_threadentries > 1
    end
  end




  # The following code was swiped directly from Railscast #168.
  # http://railscasts.com/episodes/168-feed-parsing
  # If it works, thank Ryan Bates.
  # If it doesn't, blame me.
  # Oh, yeah, I changed the field names to match my existing schema.
  def self.update_from_feed(feed)
    feed_url = feed.url
    logger.info "******* url: " + feed_url.to_s
    items = Feedzirra::Feed.fetch_and_parse(feed_url.to_s)
    add_entries(items.entries, feed.id)
  end

  def self.update_from_feed_continuously(feed, delay_interval = 15.minutes)
    feed_url = feed.url
    items = Feedzirra::Feed.fetch_and_parse(feed_url)
    logger.info "feed: " + feed.inspect
    add_entries(items.entries, feed.id)
    loop do
      sleep delay_interval
      items = Feedzirra::Feed.update(items)
      add_entries(items.new_entries, feed.id) if items.updated?
    end
  end

  private

  def self.add_entries(entries, feed_id)
    entries.each do |entry|
      logger.info '*** Viewing entry: ' + entry.inspect
      unless exists? :guid => entry.id
        create!(
          :title         => entry.title,
          :description   => entry.summary,
          :link          => entry.url,
          :pub_date      => entry.published,
          :guid          => entry.id,
          :feed_id       => feed_id
        )
      end
    end
  end

end
