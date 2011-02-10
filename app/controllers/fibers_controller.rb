class FibersController < ApplicationController
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
                  , prj.id             project_id
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
  # GET /Fibers
  # GET /Fibers.xml

  def set_fibers_table
    @qty = params[:qty].to_i

    @cable =    params[:cable].to_s
    @floorA =   params[:floorA].to_s
    @roomA =    params[:roomA].to_s
    @lineA =    params[:lineA].to_s
    @rackA =    params[:rackA].to_s
    @subA =     params[:subA].to_s
    @grupoA =   params[:grupoA].to_s
    @connectA = params[:connectA].to_s
    @fiberA =   params[:fiberA].to_i
    @fiberB =   params[:fiberB].to_i
    @floorB =   params[:floorB].to_s
    @roomB =    params[:roomB].to_s
    @lineB =    params[:lineB].to_s
    @rackB =    params[:rackB].to_s
    @subB =     params[:subB].to_s
    @grupoB =   params[:grupoB].to_s
    @connectB = params[:connectB].to_s

    render(:partial => "fibers_table", :locals => { :qty => @qty })
  end

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
    @span = Span.find(params[:span_id]) if params[:span_id]
    @fiber = Fiber.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fiber }
    end
  end

  # GET /Fibers/new
  # GET /Fibers/new.xml
  def new_table
    @span = Span.find(params[:id]) if params[:id]
    @cable = Cable.find(params[:cable_id]) if params[:cable_id]
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
  def create_table
    fibers = params[:fiber]
    puts ">>>>>>>>>>>>>>" + params[:fiber][1].to_s
    span_id = params[:span_id]
    site_a_id = params[:site_a_id]
    site_b_id = params[:site_b_id]
    @qty = params[:qty].to_i

    has_error = false
    Fiber.transaction do

contador = 0

    begin
      fibers.each do |f|
          cable = Cable.first(:conditions => ["name = ? AND span_id = ?", f[:cable_name], span_id])
          subrack_A = Subrack.first(:conditions => ["name = ? AND site_id = ? AND floor = ? AND room = ? AND line = ? AND rack = ? AND grupo = ? AND connector = ? ",
                                                  f[:subA], site_a_id, f[:floorA], f[:roomA], f[:lineA], f[:rackA], f[:grupoA], f[:connectA]])
          subrack_B = Subrack.first(:conditions => ["name = ? AND site_id = ? AND floor = ? AND room = ? AND line = ? AND rack = ? AND grupo = ? AND connector = ? ",
                                                  f[:subB], site_b_id, f[:floorB], f[:roomB], f[:lineB], f[:rackB], f[:grupoB], f[:connectB]])

contador = contador + 1
puts "Iteração ==================> "+contador.to_s

puts "cable.name = "+f[:cable_name]
puts "cable.span_id = "+span_id.to_s
puts "subrack_A.name = "+f[:subA].to_s
puts "subrack_A.floor = "+ f[:floorA].to_s
puts "subrack_A.room = "+ f[:roomA].to_s
puts "subrack_A.line = "+ f[:lineA].to_s
puts "subrack_A.rack = "+ f[:rackA].to_s
puts "subrack_A.grupo = "+ f[:grupoA].to_s
puts "subrack_A.connector = "+ f[:connectA].to_s
puts "subrack_A.site_id = "+ site_a_id
puts "subrack_B.name = "+ f[:subB].to_s
puts "subrack_B.floor = "+ f[:floorB].to_s
puts "subrack_B.room = "+ f[:roomB].to_s
puts "subrack_B.line = "+ f[:lineB].to_s
puts "subrack_B.rack = "+ f[:rackB].to_s
puts "subrack_B.grupo = "+ f[:grupoB].to_s
puts "subrack_B.connector = "+ f[:connectB].to_s
puts "subrack_B.site_id = "+ site_b_id
#puts "fiber.cable_id = "+ cable.id.to_s
puts "fiber.number_a = "+ f[:number_a].to_s
puts "fiber.number_b = "+ f[:number_b].to_s
#puts "fiber.subrack_a_id = "+ subrack_A.id.to_s
#puts "fiber.subrack_b_id = "+ subrack_B.id.to_s
#puts "fiber.status = "+ "C"


      end
      rescue
        has_error = true
        raise ActiveRecord::Rollback
      end
    end
    return render(:text => "Ext.Msg.alert('Error','There has been a problem while creating this request! Contact the system administrator.');".to_js) if has_error
    render(
      :text =>
      ( "Ext.Msg.alert('Fibers added','The fibers has been successfully created');"+
        "closeTab('tab_fibers');"
      ).to_js
    )
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
