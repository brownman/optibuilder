class TestOtdrsController < ApplicationController
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

  # GET /test_otdrs
  # GET /test_otdrs.xml
  def index
    @test_otdrs = TestOtdr.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_otdrs }
    end
  end

  # GET /test_otdrs/1
  # GET /test_otdrs/1.xml
  def show
    @test_otdr = TestOtdr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_otdr }
    end
  end

  # GET /test_otdrs/new
  # GET /test_otdrs/new.xml
  def new
    @test_otdr = TestOtdr.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_otdr }
    end
  end

  # GET /test_otdrs/1/edit
  def edit
    @test_otdr = TestOtdr.find(params[:id])
  end

  # POST /test_otdrs
  # POST /test_otdrs.xml
  def create
    @test_otdr = TestOtdr.new(params[:test_otdr])

    respond_to do |format|
      if @test_otdr.save
        format.html { redirect_to(@test_otdr, :notice => 'TestOtdr was successfully created.') }
        format.xml  { render :xml => @test_otdr, :status => :created, :location => @test_otdr }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_otdr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_otdrs/1
  # PUT /test_otdrs/1.xml
  def update
    @test_otdr = TestOtdr.find(params[:id])

    respond_to do |format|
      if @test_otdr.update_attributes(params[:test_otdr])
        format.html { redirect_to(@test_otdr, :notice => 'TestOtdr was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_otdr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_otdrs/1
  # DELETE /test_otdrs/1.xml
  def destroy
    @test_otdr = TestOtdr.find(params[:id])
    @test_otdr.destroy

    respond_to do |format|
      format.html { redirect_to(test_otdrs_url) }
      format.xml  { head :ok }
    end
  end
end
