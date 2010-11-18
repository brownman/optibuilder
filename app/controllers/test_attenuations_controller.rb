class TestAttenuationsController < ApplicationController
  # GET /test_attenuations
  # GET /test_attenuations.xml
  def index
    @test_attenuations = TestAttenuation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_attenuations }
    end
  end

  # GET /test_attenuations/1
  # GET /test_attenuations/1.xml
  def show
    @test_attenuation = TestAttenuation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_attenuation }
    end
  end

  # GET /test_attenuations/new
  # GET /test_attenuations/new.xml
  def new
    @test_attenuation = TestAttenuation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_attenuation }
    end
  end

  # GET /test_attenuations/1/edit
  def edit
    @test_attenuation = TestAttenuation.find(params[:id])
  end

  # POST /test_attenuations
  # POST /test_attenuations.xml
  def create
    @test_attenuation = TestAttenuation.new(params[:test_attenuation])

    respond_to do |format|
      if @test_attenuation.save
        format.html { redirect_to(@test_attenuation, :notice => 'TestAttenuation was successfully created.') }
        format.xml  { render :xml => @test_attenuation, :status => :created, :location => @test_attenuation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_attenuation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_attenuations/1
  # PUT /test_attenuations/1.xml
  def update
    @test_attenuation = TestAttenuation.find(params[:id])

    respond_to do |format|
      if @test_attenuation.update_attributes(params[:test_attenuation])
        format.html { redirect_to(@test_attenuation, :notice => 'TestAttenuation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_attenuation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_attenuations/1
  # DELETE /test_attenuations/1.xml
  def destroy
    @test_attenuation = TestAttenuation.find(params[:id])
    @test_attenuation.destroy

    respond_to do |format|
      format.html { redirect_to(test_attenuations_url) }
      format.xml  { head :ok }
    end
  end
end
