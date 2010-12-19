class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.xml
  def index
    @authentications = current_user.authentications if current_user
  end

  # GET /authentications/1
  # GET /authentications/1.xml
  def show
    @authentication = Authentication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @authentication }
    end
  end

  # GET /authentications/new
  # GET /authentications/new.xml
  def new
    @authentication = Authentication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @authentication }
    end
  end

  # GET /authentications/1/edit
  def edit
    @authentication = Authentication.find(params[:id])
  end

  # POST /authentications
  # POST /authentications.xml
  def create
    omniauth = request.env['omniauth.auth'] 
    current_user.authentications.find_or_create_by_provider_and_uid(:provider => omniauth['provider'], :uid=>omniauth['uid'])
    flash[:notice] = "Authentication successful."
    redirect_to authentications_url
    # render :text => request.env['omniauth.auth'].to_yaml
    # @authentication = Authentication.new(params[:authentication])

    # respond_to do |format|
    #   if @authentication.save
    #     format.html { redirect_to(@authentication, :notice => 'Authentication was successfully created.') }
    #     format.xml  { render :xml => @authentication, :status => :created, :location => @authentication }
    #   else
    #     format.html { render :action => "new" }
    #     format.xml  { render :xml => @authentication.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # PUT /authentications/1
  # PUT /authentications/1.xml
  def update
    @authentication = Authentication.find(params[:id])

    respond_to do |format|
      if @authentication.update_attributes(params[:authentication])
        format.html { redirect_to(@authentication, :notice => 'Authentication was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @authentication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.xml
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyued authentication."
    redirect_to authentications_url
  end
end
