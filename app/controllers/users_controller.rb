class UsersController < ApplicationController

  # GET /users/store/id
  # JSON
  def store
    list = []
    conditions = ""
    conditions = ["users.name LIKE ? OR users.login LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
    users = User.all( :select => "users.*, companies.name AS company_name",
                      :joins => :company,
                      :conditions => conditions,
                      :limit => params[:limit],
                      :offset => params[:start],
                      :order => "users.name, users.login"
                    )
    total = User.count(:conditions => conditions, :joins => :company)
    render(:json => {:success => true, :root => users, :totalCount => total})
  end

  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { render :json => {:success => true} }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :json => ( (@user.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @user.errors.empty?
        format.html { render :json => {:success => false} }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    if not params[:change_password]
      params[:user][:password] = nil
      params[:user][:password_confirmation] = nil
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { render(:json => {:success => true}) }
        #format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    
    if @user.id == 20
        format.html { render :json => ( "Administrator user cannot be destroyed".to_json ) }
        format.html { render :json => {:success => false} }
	return
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end
  end
end
