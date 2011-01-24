class CablesController < ApplicationController
  # GET /cables/store/id
  # JSON
   def store
      select = ""
      select = " cables.id
               , cables.name          cable_name
               , cables.network_type  network_type
               , spans.id             span_id
               , spans.project_id     project_id
               , spans.company_id     company_id
               , comp.name            company_name
               , prj.name             project_name
               , sita.id              site_a_id
               , sitb.id              site_b_id
               , sita.name            site_a_name
               , sitb.name            site_b_name"
      from = " cables
                 JOIN spans          ON (spans.id = cables.span_id)
                 JOIN projects prj   ON (spans.project_id = prj.id)
                 JOIN companies comp ON (spans.company_id = comp.id)
                 JOIN sites sita     ON (spans.site_a_id = sita.id)
                 JOIN sites sitb     ON (spans.site_b_id = sitb.id)"
      conditions = "prj.id IN (SELECT project_id FROM users_projects WHERE user_id = "+session_user.id.to_s+")"
      conditions =  ["cables.name LIKE ? OR comp.name LIKE ? OR prj.name LIKE ? AND prj.id IN (SELECT project_id FROM users_projects WHERE user_id = "+session_user.id.to_s+")", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
      conditions =  ["span_id = ?", "#{params[:span_id]}"] if params[:span_id]

      cables = Cable.all(
                :select => select,
                :conditions => conditions,
                :limit => params[:limit],
                :offset => params[:start],
                :from => from,
                :order => "cable_name, project_id, site_a_name"
      )
      total = Cable.count(:from => from, :conditions => conditions)
#      total = cables.size

      render(:json => {:success => true, :root => cables, :totalCount => total})
   end

  # GET /cables
  # GET /cables.xml
  def index
    @cables = Cable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cables }
    end
  end

  # GET /cables/1
  # GET /cables/1.xml
  def show
    @cable = Cable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cable }
    end
  end

  # GET /cables/new
  # GET /cables/new.xml
  def new
    @cable = Cable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cable }
    end
  end

  # GET /cables/1/edit
  def edit
    @cable = Cable.find(params[:id])
  end

  # POST /cables
  # POST /cables.xml
  def create
      begin
        @cable = Cable.new(params[:cable])
        respond_to do |format|
          if @cable.save
            format.html { render :json => {:success => true} }
            format.xml  { render :xml => @cable, :status => :created, :location => @cable }
          else
            format.html { render :json => ( (@cable.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @cable.errors.empty?
            format.html { render :json => {:success => false} }
            format.xml  { render :xml => @cable.errors, :status => :unprocessable_entity }
          end
        end
    end
  end

  # PUT /cables/1
  # PUT /cables/1.xml
  def update
    @cable = Cable.find(params[:id])
    respond_to do |format|
      if @cable.update_attributes(params[:cable])
          format.html { render(:json => {:success => true}) }
          format.xml  { head :ok }
      else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @cable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cables/1
  # DELETE /cables/1.xml
  def destroy
    @cable = Cable.find(params[:id])
    @cable.destroy

    respond_to do |format|
      format.html { redirect_to(cables_url) }
      format.xml  { head :ok }
    end
  end
end
