class FeedsController < ApplicationController
  before_filter :authenticate_user!

  # GET /feeds
  # GET /feeds.xml
  def index
    @feeds = current_user.feeds.all
    
    # sort_feeds
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feeds }
    end
  end

  def sort_feeds
    index = 0
    @feeds.each do |feed|
      feed.sort_order = index
      feed.save
      index = index + 1
    end
  end


  # GET /feeds/1
  # GET /feeds/1.xml
  def show
    puts "********** feeds.show"
    @feed = current_user.feeds.find(params[:id])
    if params.has_key? :thread_id
      thread_id = params[:thread_id]
      thread = FeedItem.find(thread_id)
      @feed.subfeed_by_title thread.title
    end

    logger.debug "log: @feed: " + @feed.inspect

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feed }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.xml
  def new
    @feed = Feed.new
    @feed.user_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feed }
    end
  end

  # GET /feeds/1/edit
  def edit
    # @feed = Feed.find(params[:id])
    @feed = current_user.feeds.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.xml
  def create
    @feed = Feed.new(params[:feed])
    @feed.user_id = current_user.id

    respond_to do |format|
      if @feed.save
        format.html { redirect_to(url_for(:controller=>'feed_items', :action=>'refresh', :feed_id=>@feed.id)) }
        # format.html { redirect_to(@feed, :notice => 'Feed was successfully created.') }
        format.xml  { render :xml => @feed, :status => :created, :location => @feed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.xml
  def update
    # @feed = Feed.find(params[:id])
    @feed = current_user.feeds.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to(@feed, :notice => 'Feed was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.xml
  def destroy
    # puts "in feeds.destroy"
    # @feed = Feed.find(params[:id])
    @feed = current_user.feeds.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to(feeds_url) }
      format.xml  { head :ok }
    end
  end
end
