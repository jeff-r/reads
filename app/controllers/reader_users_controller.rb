class ReaderUsersController < ApplicationController
  # GET /reader_users
  # GET /reader_users.xml
  def index
    @reader_users = ReaderUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reader_users }
    end
  end

  # GET /reader_users/1
  # GET /reader_users/1.xml
  def show
    @reader_user = ReaderUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reader_user }
    end
  end

  # GET /reader_users/new
  # GET /reader_users/new.xml
  def new
    @reader_user = ReaderUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reader_user }
    end
  end

  # GET /reader_users/1/edit
  def edit
    @reader_user = ReaderUser.find(params[:id])
  end

  # POST /reader_users
  # POST /reader_users.xml
  def create
    @reader_user = ReaderUser.new(params[:reader_user])

    respond_to do |format|
      if @reader_user.save
        format.html { redirect_to(@reader_user, :notice => 'Reader user was successfully created.') }
        format.xml  { render :xml => @reader_user, :status => :created, :location => @reader_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reader_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reader_users/1
  # PUT /reader_users/1.xml
  def update
    @reader_user = ReaderUser.find(params[:id])

    respond_to do |format|
      if @reader_user.update_attributes(params[:reader_user])
        format.html { redirect_to(@reader_user, :notice => 'Reader user was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reader_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reader_users/1
  # DELETE /reader_users/1.xml
  def destroy
    @reader_user = ReaderUser.find(params[:id])
    @reader_user.destroy

    respond_to do |format|
      format.html { redirect_to(reader_users_url) }
      format.xml  { head :ok }
    end
  end
end
