class SitesController < ApplicationController
  # GET /Sites
  # GET /Sites.json
   def store
      if params[:id] == "grid"
         list = []
         conditions = ""
         conditions = ["sites.name LIKE ?", "%#{params[:query]}%"] if params[:query]
         conditions = ["sites.id IN (SELECT site_a_id FROM spans WHERE project_id = ? ) OR sites.id IN (SELECT site_b_id FROM spans WHERE project_id = ? )",
                       "#{params[:project_id]}", "#{params[:project_id]}"] if params[:project_id]
         sites = Site.all(:select =>  "sites.*
                                      ,companies.name AS owner_name",
                          :joins => [:owner, :address],
                          :conditions => conditions,
                          :limit => params[:limit],
                          :offset => params[:start],
                          :order => "sites.name")
         total = Site.count(:joins => [:owner, :address], :conditions => conditions)
         render(:json => {:success => true, :root => sites, :totalCount => total})
      end
   end

  # GET /Sites
  # GET /Sites.xml
  def index
    @Sites = Site.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @Sites }
    end
  end

  # GET /Sites/1
  # GET /Sites/1.xml
  def show
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /Sites/new
  # GET /Sites/new.xml
  def new
    @site = Site.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /Sites/1/edit
  def edit
    @site = Site.find(params[:id])
    @address = @site.address
  end

  # POST /Sites
  # POST /Sites.xml
  def create
   Site.transaction do
      begin
        @site = Site.new(params[:site])
        @site.address = Address.new(params[:address])
        respond_to do |format|
          if @site.save
            format.html { render :json => {:success => true} }
            format.xml  { render :xml => @site, :status => :created, :location => @site }
          else
            format.html { render :json => ( (@site.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @site.errors.empty?
            format.html { render :json => {:success => false} }
            format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
          end
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  # PUT /Sites/1
  # PUT /Sites/1.xml
  def update
     @site = Site.find(params[:id])
     respond_to do |format|
     if @site.update_attributes(params[:site])
        @site.address.update_attributes(params[:address])
        format.html { render(:json => {:success => true}) }
        format.xml  { head :ok }
     else
        format.html { render :action => "edit" }
       format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
     end
    end
  end

  # DELETE /Sites/1
  # DELETE /Sites/1.xml
  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    respond_to do |format|
      format.html { redirect_to(sites_url) }
      format.xml  { head :ok }
    end
  end
end
