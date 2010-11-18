class SpansController < ApplicationController
  # GET /spans/store/id
  # JSON
   def store
      list = []
      conditions = ""
      conditions =  ["companies.name LIKE ? OR sites.name LIKE ? OR site_bs_spans.name LIKE ?",
                     "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
      conditions =  ["site_a_id = ?", "#{params[:site_id]}"] if params[:site_id]
      spans =
      Span.all(
                :select => "spans.*, sites.name AS site_a_name, site_bs_spans.name AS site_b_name, companies.name AS company_name",
                :conditions => conditions,
                :limit => params[:limit],
                :offset => params[:start],
                :joins => [:site_a, :site_b, :company],
                :order => "project_id, company_id, sites.name, site_b_name"
      )
      total =  spans.size
      total = Span.count(:joins => [:site_a, :site_b, :company], :conditions => conditions)

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
