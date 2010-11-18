class FibersController < ApplicationController
   def store
      if params[:id] == "grid"
         list = []
         select = " f1.id             id
                   , f1.number         fiber_num_1
                   , f1.status         fiber_status_1
                   , f1.subrack_name_id subrack_name_id
                   , f2.number         fiber_num_2
                   , f2.status         fiber_status_2
                   , prj.name          project_name
                   , sra.subrack_name  subrack_a
                   , srb.subrack_name  subrack_b
                   , sita.id           site_a_id
                   , sita.name         site_a_name
                   , sitb.name         site_b_name"
         from =" fibers f1
                         left OUTER JOIN fibers f2         ON (f2.id = f1.fiber_end_id)
                         left OUTER JOIN subrack_names srb ON (f2.subrack_name_id = srb.id)
                 , spans sp
                 , projects prj
                 , subrack_names sra
                 , sites sita
                 , sites sitb"
         conditions = "f1.subrack_name_id = sra.id
                   AND f1.span_id = sp.id
                   AND sp.project_id = prj.id
                   AND sp.site_a_id = sita.id
                   AND sp.site_b_id = sitb.id"

         conditions = conditions + " AND f1.subrack_name_id = #{params[:subrack_name_id]}" if params[:subrack_name_id]

         fibers = Fiber.all(
                            :select => select,
                            :from => from,
                            :conditions => conditions,
                            :limit => params[:limit],
                            :offset => params[:start],
                            :order => "site_a_name, fiber_num_1"
                           )
         total = Fiber.count(:from => from,:conditions => conditions)
         render(:json => {:success => true, :root => fibers, :totalCount => total})
      end
   end
  # GET /Fibers
  # GET /Fibers.xml

  def index
    @Fibers = Fiber.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @Fibers }
    end
  end

  # GET /Fibers/1
  # GET /Fibers/1.xml
  def show
    @fiber = Fiber.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fiber }
    end
  end

  # GET /Fibers/new
  # GET /Fibers/new.xml
  def new
    @fiber = Fiber.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fiber }
    end
  end

  # GET /Fibers/1/edit
  def edit
    @fiber = Fiber.find(params[:id])
  end

  # POST /Fibers
  # POST /Fibers.xml
  def create
    @fiber = Fiber.new(params[:fiber])
    respond_to do |format|
      if @fiber.save
        format.html { render :json => {:success => true} }
        format.xml  { render :xml => @fiber, :status => :created, :location => @fiber }
      else
        format.html { render :json => ( (@fiber.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @fiber.errors.empty?
        format.html { render :json => {:success => false} }
        format.xml  { render :xml => @fiber.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Fibers/1
  # PUT /Fibers/1.xml
  def update
     @fiber = Fiber.find(params[:id])
     respond_to do |format|
     if @fiber.update_attributes(params[:fiber])
        format.html { render(:json => {:success => true}) }
        format.xml  { head :ok }
     else
        format.html { render :action => "edit" }
       format.xml  { render :xml => @fiber.errors, :status => :unprocessable_entity }
     end
    end
  end

  # DELETE /Fibers/1
  # DELETE /Fibers/1.xml
  def destroy
    @fiber = Fiber.find(params[:id])
    @fiber.destroy
    respond_to do |format|
      format.html { redirect_to(fibers_url) }
      format.xml  { head :ok }
    end
  end
end
