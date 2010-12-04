class FeedItem < ActiveRecord::Base
  belongs_to :feed

  def has_sub_items?
    if not num_threadentries.nil?
      num_threadentries > 1
    end
  end
end
