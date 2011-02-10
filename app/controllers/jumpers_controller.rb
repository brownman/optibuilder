class JumpersController < ApplicationController
  # GET /jumpers
  # GET /jumpers.xml
  def index
    @jumpers = Jumper.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jumpers }
    end
  end

  # GET /jumpers/1
  # GET /jumpers/1.xml
  def show
    @jumper = Jumper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jumper }
    end
  end

  # GET /jumpers/new
  # GET /jumpers/new.xml
  def new
    @jumper = Jumper.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jumper }
    end
  end

  # GET /jumpers/1/edit
  def edit
    @jumper = Jumper.find(params[:id])
  end

  # POST /jumpers
  # POST /jumpers.xml
  def create
    @jumper = Jumper.new(params[:jumper])

    respond_to do |format|
      if @jumper.save
        format.html { redirect_to(@jumper, :notice => 'Jumper was successfully created.') }
        format.xml  { render :xml => @jumper, :status => :created, :location => @jumper }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jumper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jumpers/1
  # PUT /jumpers/1.xml
  def update
    @jumper = Jumper.find(params[:id])

    respond_to do |format|
      if @jumper.update_attributes(params[:jumper])
        format.html { redirect_to(@jumper, :notice => 'Jumper was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jumper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jumpers/1
  # DELETE /jumpers/1.xml
  def destroy
    @jumper = Jumper.find(params[:id])
    @jumper.destroy

    respond_to do |format|
      format.html { redirect_to(jumpers_url) }
      format.xml  { head :ok }
    end
  end
end
