class TestChromaticDispsController < ApplicationController
  # GET /cables/store/id
  # JSON
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
         if session_user.id == 1
             conditions = ""
             conditions = ["prj.name LIKE ? OR sitea.name LIKE ? OR siteb.name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
           else
             conditions = "project_id IN (SELECT project_id FROM users_projects WHERE user_id = "+session_user.id.to_s+")"
             conditions =  ["(prj.id in (SELECT users_projects.project_id FROM users_projects WHERE users_projects.user_id="+session_user.id.to_s+")) AND (prj.name LIKE ? OR sitea.name LIKE ? OR siteb.name LIKE ?)",
                            "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
         end

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
