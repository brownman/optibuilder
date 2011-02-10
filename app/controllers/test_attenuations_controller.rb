class TestAttenuationsController < ApplicationController

     def store
      if params[:id] == "grid"
         list = []
         select = " f.id               id
                  , f.number_a         fiber_num_a
                  , f.subrack_a_id     sub_a_id
                  , f.number_b         fiber_num_b
                  , f.subrack_b_id     sub_b_id
                  , f.status           status
                  , sra.name           sub_a_name
                  , srb.name           sub_b_name
                  , cab.name           cable_name
                  , prj.name           project_name
                  , sitea.id           site_a_id
                  , sitea.name         site_a_name
                  , siteb.id           site_b_id
                  , siteb.name         site_b_name"
         from = " fibers f     JOIN subracks sra  ON (f.subrack_a_id = sra.id)
                    left OUTER JOIN subracks srb  ON (f.subrack_b_id = srb.id)
                               JOIN cables cab    ON (f.cable_id = cab.id)
                               JOIN spans sp      ON (cab.span_id = sp.id)
                               JOIN projects prj  ON (sp.project_id = prj.id)
                               JOIN sites sitea   ON (sra.site_id = sitea.id)
                               JOIN sites siteb   ON (srb.site_id = siteb.id)"
         conditions = ""
         conditions =  ["prj.name LIKE ? OR sitea.name LIKE ? OR siteb.name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]

         fibers = Fiber.all(
                            :select => select,
                            :from => from,
                            :conditions => conditions,
                            :limit => params[:limit],
                            :offset => params[:start],
                            :order => "project_name, site_a_name, fiber_num_a"
                           )
         total = Fiber.count(:from => from,:conditions => conditions)
         render(:json => {:success => true, :root => fibers, :totalCount => total})
      end
   end

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
