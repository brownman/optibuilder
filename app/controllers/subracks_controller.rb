class SubracksController < ApplicationController
   def store
      if params[:id] == "grid"
         list = []
         if session_user.id == 1
             conditions = ""
             conditions = ["sites.name LIKE ? OR subracks.name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
           else
             conditions = "site_id IN (SELECT site_a_id FROM spans s, users_projects u WHERE s.project_id=u.project_id AND user_id = "+session_user.id.to_s+" UNION SELECT site_b_id FROM spans s, users_projects u WHERE s.project_id=u.project_id AND user_id = "+session_user.id.to_s+")"
             conditions = ["(site_id IN (SELECT site_a_id FROM spans s, users_projects u WHERE s.project_id=u.project_id AND user_id = "+session_user.id.to_s+" UNION SELECT site_b_id FROM spans s, users_projects u WHERE s.project_id=u.project_id AND user_id = "+session_user.id.to_s+")) AND (sites.name LIKE ? OR subracks.name LIKE ?)", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
         end
         conditions = ["site_id = ?", "#{params[:site_id]}"] if params[:site_id]
         subracks = Subrack.all(:select => "subracks.*, sites.name AS site_name",
                                         :conditions => conditions,
                                         :limit => params[:limit],
                                         :offset => params[:start],
                                         :joins => :site,
                                         :order => "site_id, name")
         total = Subrack.count(:joins => :site, :conditions => conditions)
         render(:json => {:success => true, :root => subracks, :totalCount => total})
      end
   end


  # GET /subracks
  # GET /subracks.xml
  def index
    @subracks = Subrack.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subracks }
    end
  end

  # GET /subracks/1
  # GET /subracks/1.xml
  def show
    @subrack = Subrack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subrack }
    end
  end

  # GET /subracks/new
  # GET /subracks/new.xml
  def new
    @subrack = Subrack.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subrack }
    end
  end

  # GET /subracks/1/edit
  def edit
    @subrack = Subrack.find(params[:id])
  end

  # POST /subracks
  # POST /subracks.xml
  def create
    @subrack = Subrack.new(params[:subrack])

    respond_to do |format|
      if @subrack.save
        format.html { render :json => {:success => true} }
        format.xml  { render :xml => @subrack, :status => :created, :location => @subrack }
      else
        format.html { render :json => ( (@subrack.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @subrack.errors.empty?
        format.html { render :json => {:success => false} }
        format.xml  { render :xml => @subrack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subracks/1
  # PUT /subracks/1.xml
  def update
    @subrack = Subrack.find(params[:id])

    respond_to do |format|
      if @subrack.update_attributes(params[:subrack])
          format.html { render(:json => {:success => true}) }
          format.xml  { head :ok }
      else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @subrack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subracks/1
  # DELETE /subracks/1.xml
  def destroy
    @subrack = Subrack.find(params[:id])
    @subrack.destroy

    respond_to do |format|
      format.html { redirect_to(subracks_url) }
      format.xml  { head :ok }
    end
  end
end
