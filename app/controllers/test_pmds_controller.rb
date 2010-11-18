class TestPmdsController < ApplicationController
  # GET /test_pmds
  # GET /test_pmds.xml
  def index
    @test_pmds = TestPmd.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_pmds }
    end
  end

  # GET /test_pmds/1
  # GET /test_pmds/1.xml
  def show
    @test_pmd = TestPmd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_pmd }
    end
  end

  # GET /test_pmds/new
  # GET /test_pmds/new.xml
  def new
    @test_pmd = TestPmd.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_pmd }
    end
  end

  # GET /test_pmds/1/edit
  def edit
    @test_pmd = TestPmd.find(params[:id])
  end

  # POST /test_pmds
  # POST /test_pmds.xml
  def create
    @test_pmd = TestPmd.new(params[:test_pmd])

    respond_to do |format|
      if @test_pmd.save
        format.html { redirect_to(@test_pmd, :notice => 'TestPmd was successfully created.') }
        format.xml  { render :xml => @test_pmd, :status => :created, :location => @test_pmd }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_pmd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_pmds/1
  # PUT /test_pmds/1.xml
  def update
    @test_pmd = TestPmd.find(params[:id])

    respond_to do |format|
      if @test_pmd.update_attributes(params[:test_pmd])
        format.html { redirect_to(@test_pmd, :notice => 'TestPmd was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_pmd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_pmds/1
  # DELETE /test_pmds/1.xml
  def destroy
    @test_pmd = TestPmd.find(params[:id])
    @test_pmd.destroy

    respond_to do |format|
      format.html { redirect_to(test_pmds_url) }
      format.xml  { head :ok }
    end
  end
end
