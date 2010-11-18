class TestOrlsController < ApplicationController
  # GET /test_orls
  # GET /test_orls.xml
  def index
    @test_orls = TestOrl.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_orls }
    end
  end

  # GET /test_orls/1
  # GET /test_orls/1.xml
  def show
    @test_orl = TestOrl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_orl }
    end
  end

  # GET /test_orls/new
  # GET /test_orls/new.xml
  def new
    @test_orl = TestOrl.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_orl }
    end
  end

  # GET /test_orls/1/edit
  def edit
    @test_orl = TestOrl.find(params[:id])
  end

  # POST /test_orls
  # POST /test_orls.xml
  def create
    @test_orl = TestOrl.new(params[:test_orl])

    respond_to do |format|
      if @test_orl.save
        format.html { redirect_to(@test_orl, :notice => 'TestOrl was successfully created.') }
        format.xml  { render :xml => @test_orl, :status => :created, :location => @test_orl }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_orl.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_orls/1
  # PUT /test_orls/1.xml
  def update
    @test_orl = TestOrl.find(params[:id])

    respond_to do |format|
      if @test_orl.update_attributes(params[:test_orl])
        format.html { redirect_to(@test_orl, :notice => 'TestOrl was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_orl.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_orls/1
  # DELETE /test_orls/1.xml
  def destroy
    @test_orl = TestOrl.find(params[:id])
    @test_orl.destroy

    respond_to do |format|
      format.html { redirect_to(test_orls_url) }
      format.xml  { head :ok }
    end
  end
end
