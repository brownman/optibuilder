class TestPmdsController < ApplicationController

  # GET /projects/store/id
  # JSON
 def store
      if params[:id] == "grid"
        list = []

          if session_user.id == 1

              conditions = ""
              conditions =[ "fiber_id =?", "#{params[:query]}"] if params[:query]
          else
              conditions = "test_pmds.id in (select project_id from users_projects where user_id = "+session_user.id.to_s+")"
              conditions =["(prj.id in (SELECT users_projects.project_id FROM users_projects WHERE users_projects.user_id="+session_user.id.to_s+")) AND (fiber_id = ?)","%#{params[:query]}%"] if params[:query]

          end
          test_pmds = TestPmd.all(:select =>  "test_pmds.*",
                                 :conditions => conditions,
                                 :limit => params[:limit],
                                 :offset => params[:start],
                                 :order => "created_at"
          )

          total = TestPmd.count( :conditions => conditions)
          render(:json => {:success => true, :root => test_pmds, :totalCount => total})
      end
 end

def fibers_store
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


def show_tests_for_fiber
    @fiber = Fiber.find(params[:id])
    @test_pmds = @fiber.test_pmds

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_pmd }
    end
  end

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
    if params[:query]
         @test_pmd = TestPmd.new
        @fiber = Fiber.find(params[:query])
    else
        @test_pmd = TestPmd.new
        @fiber = Fiber.find(params[:id])
    end
 respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_pmd }
    end
end

  # GET /test_pmds/1/edit
  def edit

    select = " id"
    from = "fibers"
    conditions =[ "id IN (SELECT p.fiber_id from test_pmds p where p.id =? )  ", "#{params[:query]}", "%#{params[:query]}%"] if params[:query]
    @test_pmd = TestPmd.find(params[:id])
    @fiber = Fiber.all(
                            :select => select,
                            :from => from,
                            :conditions => conditions
                           )
  end

  # POST /test_pmds
  # POST /test_pmds.xml
  def create
    TestPmd.transaction do
      begin
        @test_pmd = TestPmd.new(params[:test_pmd])


        respond_to do |format|
          if @test_pmd.save

            format.html { render :json => {:success => true} }
            format.xml  { render :xml => @test_pmd, :status => :created, :location => @test_pmd }
          else
            format.html { render :json => ( (@test_pmd.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @test_pmd.errors.empty?
            format.html { render :json => {:success => false} }
            format.xml  { render :xml => @test_pmd.errors, :status => :unprocessable_entity }
          end
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
  # PUT /test_pmds/1
  # PUT /test_pmds/1.xml
  def update
    TestPmd.transaction do
      begin
         @test_pmd = TestPmd.find(params[:id])
            respond_to do |format|
              if @test_pmd.update_attributes(params[:test_pmd])
                format.html { render :json => {:success => true} }
                format.xml  { head :ok }
              else
                 format.html { render :action => "edit" }
                 format.xml  { render :xml => @test_pmd.errors, :status => :unprocessable_entity }

            end
          end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  # DELETE /test_pmds/1
  # DELETE /test_pmds/1.xml
 def destroy
    TestPmd.transaction do
      begin
        @test_pmd = TestPmd.find(params[:id])
        @fiber_id = @test_pmd.fiber_id
        @test_pmd.destroy
      rescue
        raise ActiveRecord::Rollback
      end
    end
    respond_to do |format|
      format.html { redirect_to(:action => "show_tests_for_fiber", :id => @fiber_id ) }
      format.xml  { head :ok }
    end
  end
end
