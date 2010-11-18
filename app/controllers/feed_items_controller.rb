class FeedItemsController < ApplicationController
  before_filter :authenticate_user!

  # GET /feed_items
  # GET /feed_items.xml
  def index
    @feed_items = FeedItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feed_items }
    end
  end
  
  def delete_all_items
    if params.has_key? "feed_id"
      items = FeedItem.where("feed_id = #{params['feed_id']}")
    else
      items = FeedItem.all
    end
    items.each do |item|
      item.delete
    end
    
    if params.has_key? "feed_id"
      redirect_to url_for(:controller=>'feeds', :action=>'show', :id=>params['feed_id'])
    else
      redirect_to url_for(:controller=>'feeds', :action=>'index')
    end
  end

  def refresh
    @feed = Feed.find(params[:feed_id])
    # @feed_items = FeedItem.all
    
    puts "@feed.url: #{@feed.url.inspect}" 
    url = URI.parse @feed.url
    @theresponse = Net::HTTP.get_response(url)
    # puts "@theresponse: #{@theresponse.inspect}" 
    @theresponse = @theresponse.body
    
    hash = Hash.from_xml(@theresponse)
    # puts "hash: #{hash.inspect}" 
    
    # feed = Feed.new
    @theresponse = hash["keys"]
    # puts "keys: #{hash['rss']['channel'].keys}\n"
    channel = hash['rss']['channel']
    # channel.keys: ["generator", "title", "link", "language", "webMaster", "copyright", "pubDate", "lastBuildDate", "image", "item", "description"]
    
    
    items = channel['item']
    first = items[0]
    # items is an array of item hashes. Each item has these keys:
    # items[n].keys = ["title", "link", "guid", "category", "pubDate", "description"]
    
    lastupdate = @feed.most_recent_item_time
    items.each do |item|
      pd = DateTime.parse item['pubDate']
      
      if pd.to_time > lastupdate.to_time
        it = FeedItem.create :title=>item['title'], :link=>item['link'], :read=>false, :description=>item['description'], :pub_date=>item['pubDate']
        @feed.feed_items << it
      else
        puts "#{item['title']} not saved because it was in the past"
      end
    end
    
    @feed.save
    
    redirect_to url_for(:controller=>:feeds, :action=>:show, :id=>@feed.id)

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @feed_items }
    # end
  end
  

  # GET /feed_items/1
  # GET /feed_items/1.xml
  def show
    @feed_item = FeedItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feed_item }
    end
  end

  # GET /feed_items/new
  # GET /feed_items/new.xml
  def new
    @feed_item = FeedItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feed_item }
    end
  end

  # GET /feed_items/1/edit
  def edit
    @feed_item = FeedItem.find(params[:id])
  end

  # POST /feed_items
  # POST /feed_items.xml
  def create
    @feed_item = FeedItem.new(params[:feed_item])

    respond_to do |format|
      if @feed_item.save
        format.html { redirect_to(@feed_item, :notice => 'Feed item was successfully created.') }
        format.xml  { render :xml => @feed_item, :status => :created, :location => @feed_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feed_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feed_items/1
  # PUT /feed_items/1.xml
  def update
    puts "**************** in update"
    puts "params.keys: #{params.keys.inspect}" 
    if params.keys.include?('read_item_id')
      item = FeedItem.find(params[:read_item_id])
      item.read = true
      item.save
      # redirect_to url_for(:controller=>:feeds, :action=>:show, :id=>item.feed.id)
      respond_to do |format|
        format.html { redirect_to(@feed_item, :notice => 'Feed item was successfully updated.') }
        format.xml  { head :ok }
      end
    else
      redirect_to url_for(:controller=>:feeds, :action=>:show, :id=>1)
    end
    
    @feed_item = FeedItem.find(params[:id])
    
    # respond_to do |format|
    #   if @feed_item.update_attributes(params[:feed_item])
    #     format.html { redirect_to(@feed_item, :notice => 'Feed item was successfully updated.') }
    #     format.xml  { head :ok }
    #   else
    #     format.html { render :action => "edit" }
    #     format.xml  { render :xml => @feed_item.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /feed_items/1
  # DELETE /feed_items/1.xml
  def destroy
    puts "************************  in destroy"
    
    @feed_item = FeedItem.find(params[:id])
    feed = @feed_item.feed
    @feed_item.destroy

    redirect_to url_for(:controller=>:feeds, :action=>:show, :id=>feed.id)
    

    # respond_to do |format|
    #   format.html { redirect_to(feed_items_url) }
    #   format.xml  { head :ok }
    # end
  end
end
