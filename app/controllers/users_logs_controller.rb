class UsersLogsController < ApplicationController
  # GET /users_logs
  # GET /users_logs.xml
  def index
    @users_logs = UsersLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users_logs }
    end
  end

  # GET /users_logs/1
  # GET /users_logs/1.xml
  def show
    @users_log = UsersLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @users_log }
    end
  end

  # GET /users_logs/new
  # GET /users_logs/new.xml
  def new
    @users_log = UsersLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_log }
    end
  end

  # GET /users_logs/1/edit
  def edit
    @users_log = UsersLog.find(params[:id])
  end

  # POST /users_logs
  # POST /users_logs.xml
  def create
    @users_log = UsersLog.new(params[:users_log])

    respond_to do |format|
      if @users_log.save
        format.html { redirect_to(@users_log, :notice => 'UsersLog was successfully created.') }
        format.xml  { render :xml => @users_log, :status => :created, :location => @users_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @users_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users_logs/1
  # PUT /users_logs/1.xml
  def update
    @users_log = UsersLog.find(params[:id])

    respond_to do |format|
      if @users_log.update_attributes(params[:users_log])
        format.html { redirect_to(@users_log, :notice => 'UsersLog was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @users_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users_logs/1
  # DELETE /users_logs/1.xml
  def destroy
    @users_log = UsersLog.find(params[:id])
    @users_log.destroy

    respond_to do |format|
      format.html { redirect_to(users_logs_url) }
      format.xml  { head :ok }
    end
  end
end
