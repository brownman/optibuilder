class TestChromaticDispsController < ApplicationController
  # GET /test_chromatic_disps
  # GET /test_chromatic_disps.xml
  def index
    @test_chromatic_disps = TestChromaticDisp.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_chromatic_disps }
    end
  end

  # GET /test_chromatic_disps/1
  # GET /test_chromatic_disps/1.xml
  def show
    @test_chromatic_disp = TestChromaticDisp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_chromatic_disp }
    end
  end

  # GET /test_chromatic_disps/new
  # GET /test_chromatic_disps/new.xml
  def new
    @test_chromatic_disp = TestChromaticDisp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_chromatic_disp }
    end
  end

  # GET /test_chromatic_disps/1/edit
  def edit
    @test_chromatic_disp = TestChromaticDisp.find(params[:id])
  end

  # POST /test_chromatic_disps
  # POST /test_chromatic_disps.xml
  def create
    @test_chromatic_disp = TestChromaticDisp.new(params[:test_chromatic_disp])

    respond_to do |format|
      if @test_chromatic_disp.save
        format.html { redirect_to(@test_chromatic_disp, :notice => 'TestChromaticDisp was successfully created.') }
        format.xml  { render :xml => @test_chromatic_disp, :status => :created, :location => @test_chromatic_disp }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_chromatic_disp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_chromatic_disps/1
  # PUT /test_chromatic_disps/1.xml
  def update
    @test_chromatic_disp = TestChromaticDisp.find(params[:id])

    respond_to do |format|
      if @test_chromatic_disp.update_attributes(params[:test_chromatic_disp])
        format.html { redirect_to(@test_chromatic_disp, :notice => 'TestChromaticDisp was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_chromatic_disp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_chromatic_disps/1
  # DELETE /test_chromatic_disps/1.xml
  def destroy
    @test_chromatic_disp = TestChromaticDisp.find(params[:id])
    @test_chromatic_disp.destroy

    respond_to do |format|
      format.html { redirect_to(test_chromatic_disps_url) }
      format.xml  { head :ok }
    end
  end
end
