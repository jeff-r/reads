class Trail < ActiveRecord::Base
  has_many :links
  belongs_to :user
  belongs_to :page

  def column
    self.column_id ||= 0
  end
  def column= val
    self.column_id = val
  end

  # loop through the Link objects with the given indexes,
  # and assign them this trail's id and consecutive sort indexes
  def gather_links indexes
    sort_index = 0
    indexes.each do |index|
      link = Link.find(index)
      link.trail_id = self.id
      link.sort_index = sort_index
      link.save
      sort_index = sort_index + 1
    end
  end

  def self.get_columns_of_trails trails
    cols = [ [], [], [], [] ]
    trails.each do |trail|
      cols[trail.column] << trail
      puts "getting trail: " + trail.inspect
      puts trail.column.inspect
    end
    
    dump_cols cols
    cols
  end

  def self.dump_cols cols
    cols.each do |col|
      puts "col: "
      col.each do |item|
        puts "  item: " + item.title
      end
    end
  end
end
