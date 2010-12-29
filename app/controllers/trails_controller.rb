class TrailsController < ApplicationController


  def get_columns_of_trails
    cols = [ [], [], [], [] ]
    current_user.sorted_trails.each do |trail|
      cols[trail.column] << trail
      puts "getting trail: " + trail.inspect
      puts trail.column.inspect
    end
    
    dump_cols cols
    cols
  end

  def dump_cols cols
    cols.each do |col|
      puts "col: "
      col.each do |item|
        puts "  item: " + item.title
      end
    end
  end





  # GET /trails
  # GET /trails.xml
  def index
    # @trails = Trail.all
    if current_user.trails.count == 0
      puts '***** Redirecting'
      redirect_to new_trail_path
      return
    end
    if current_user.setting.nil?
      current_user.setting = Setting.new
      current_user.setting.save
    end
    if current_user.setting.current_trail_id.nil?
      puts "*** current_user: " + current_user.inspect
      puts "*** current_user.trails: " + current_user.trails.inspect
      puts "*** current_user.trails.count: " + current_user.trails.count.inspect
      current_user.setting.current_trail_id = current_user.trails.first.id
      current_user.setting.save
    end
    if params.has_key? "set_current_trail_id"
      current_user.setting.current_trail_id = params[:set_current_trail_id]
      current_user.setting.save
    end

    @cols = get_columns_of_trails

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trails }
    end
  end

  # GET /trails/1
  # GET /trails/1.xml
  def show
    @trail = Trail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trail }
    end
  end

  # GET /trails/new
  # GET /trails/new.xml
  def new
    @trail = Trail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trail }
    end
  end

  # GET /trails/1/edit
  def edit
    @trail = Trail.find(params[:id])
  end

  # POST /trails
  # POST /trails.xml
  def create
    @trail = Trail.new(params[:trail])
    @trail.user_id = current_user.id
    @trail.sort_index = 0
    @trail.column = 0

    respond_to do |format|
      if @trail.save
        format.html { redirect_to(@trail, :notice => 'Trail was successfully created.') }
        format.xml  { render :xml => @trail, :status => :created, :location => @trail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trails/1
  # PUT /trails/1.xml
  def update
    @trail = Trail.find(params[:id])

    respond_to do |format|
      if @trail.update_attributes(params[:trail])
        format.html { redirect_to(@trail, :notice => 'Trail was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trails/1
  # DELETE /trails/1.xml
  def destroy
    @trail = Trail.find(params[:id])
    @trail.destroy

    respond_to do |format|
      format.html { redirect_to(trails_url) }
      format.xml  { head :ok }
    end
  end

  def sortorder
    logger.error "** in sortorder"
    logger.error params.inspect
    render :xml => params

    column_index = params[:column_index]
    trailindexes = params[:indexes]
    sort_index = 0
    trailindexes.each do |index|
      trail = Trail.find(index)
      trail.column_id = column_index
      trail.sort_index = sort_index
      sort_index += 1
      trail.save
      puts "saving trail: " + trail.inspect
    end

    # respond_to do |format|
    #   format.html { redirect_to index }
    #   # format.xml  { head :ok }
    # end
  end


  def setcurrent
    logger.error 'in setcurrent'
    current_user.setting.current_trail_id = params[:trailid]
    current_user.setting.save
    render :xml => params
    # redirect_to index
  end

end
