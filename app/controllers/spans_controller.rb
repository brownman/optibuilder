class SpansController < ApplicationController
  # GET /spans/store/id
  # JSON
   def store
      list = []
      if session_user.id == 1
          conditions = ""
          conditions = ["sites.name LIKE ?", "%#{params[:query]}%"] if params[:query]
        else
          conditions = "project_id IN (SELECT project_id FROM users_projects WHERE user_id = "+session_user.id.to_s+")"
          conditions =  ["(companies.name LIKE ? OR projects.name LIKE ? OR sites.name LIKE ? OR site_bs_spans.name LIKE ?) AND (project_id IN (SELECT project_id FROM users_projects WHERE user_id = "+session_user.id.to_s+"))",
                         "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
      end
      conditions =  ["site_a_id = ? OR site_b_id = ?", "#{params[:site_id]}", "#{params[:site_id]}"] if params[:site_id]
      conditions =  ["project_id = ?", "#{params[:project_id]}"] if params[:project_id]

      select = ""
      select = "spans.*, sites.name AS site_a_name, site_bs_spans.name AS site_b_name,projects.name AS project_name, companies.name AS company_name"
      select = ["if(site_a_id=?,site_b_id,site_a_id) site", "%#{params[:site_a_id]}%"] if params[:site_a_id]

      spans = Span.all(
                :select => select,
                :conditions => conditions,
                :limit => params[:limit],
                :offset => params[:start],
                :joins => [:site_a, :site_b, :company, :project],
                :order => "project_id, company_id, sites.name, site_b_name"
      )
      total = Span.count(:joins => [:site_a, :site_b, :company, :project], :conditions => conditions)

      spans.each do |s|
        list << {
          :id => s.id,
          :site_a_id => s.site_a_id,
          :site_b_id => s.site_b_id,
          :company_id => s.company_id,
          :distance => s.distance,
          :project_id => s.project_id,
          :site_a_name => s.site_a_name,
          :site_b_name => s.site_b_name,
          :company_name => s.company.name,
          :project_name => s.project.name,
          :sitea_siteb => s.site_a.name + " - " + s.site_b.name
        }
      end

      render(:json => {:success => true, :root => list, :totalCount => total})
   end

  # GET /spans
  # GET /spans.xml
  def index
    @spans = Span.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spans }
    end
  end

  # GET /spans/1
  # GET /spans/1.xml
  def show
    @span = Span.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @span }
    end
  end

  # GET /spans/new
  # GET /spans/new.xml
  def new
    @span = Span.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @span }
    end
  end

  # GET /spans/1/edit
  def edit
    @span = Span.find(params[:id])
  end

  # POST /spans
  # POST /spans.xml
  def create
      begin
        @span = Span.new(params[:span])
        respond_to do |format|
          if @span.save
            format.html { render :json => {:success => true} }
            format.xml  { render :xml => @span, :status => :created, :location => @span }
          else
            format.html { render :json => ( (@span.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @span.errors.empty?
            format.html { render :json => {:success => false} }
            format.xml  { render :xml => @span.errors, :status => :unprocessable_entity }
          end
        end
    end
  end

  # PUT /spans/1
  # PUT /spans/1.xml
  def update
    @span = Span.find(params[:id])
    respond_to do |format|
      if @span.update_attributes(params[:span])
          format.html { render(:json => {:success => true}) }
          format.xml  { head :ok }
      else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @span.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /spans/1
  # DELETE /spans/1.xml
  def destroy
    @span = Span.find(params[:id])
    @span.destroy

    respond_to do |format|
      format.html { redirect_to(spans_url) }
      format.xml  { head :ok }
    end
  end
end
