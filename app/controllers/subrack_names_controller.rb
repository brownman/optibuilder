class SubrackNamesController < ApplicationController
   def store
      if params[:id] == "grid"
         list = []
         conditions = ""
         conditions = ["sites.name LIKE ? OR subrack_name LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
         conditions = ["site_id = ?", "#{params[:site_id]}"] if params[:site_id]
         subrack_names = SubrackName.all(:select => "subrack_names.*, sites.name AS site_name",
                                         :conditions => conditions,
                                         :limit => params[:limit],
                                         :offset => params[:start],
                                         :joins => :site,
                                         :order => "site_id, subrack_name")
         total = SubrackName.count(:joins => :site, :conditions => conditions)
         render(:json => {:success => true, :root => subrack_names, :totalCount => total})
      end
   end


  # GET /subrack_names
  # GET /subrack_names.xml
  def index
    @subrack_names = SubrackName.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subrack_names }
    end
  end

  # GET /subrack_names/1
  # GET /subrack_names/1.xml
  def show
    @subrack_name = SubrackName.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subrack_name }
    end
  end

  # GET /subrack_names/new
  # GET /subrack_names/new.xml
  def new
    @subrack_name = SubrackName.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subrack_name }
    end
  end

  # GET /subrack_names/1/edit
  def edit
    @subrack_name = SubrackName.find(params[:id])
  end

  # POST /subrack_names
  # POST /subrack_names.xml
  def create
    @subrack_name = SubrackName.new(params[:subrack_name])

    respond_to do |format|
      if @subrack_name.save
        format.html { render :json => {:success => true} }
        format.xml  { render :xml => @subrack_name, :status => :created, :location => @subrack_name }
      else
        format.html { render :json => ( (@subrack_name.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @subrack_name.errors.empty?
        format.html { render :json => {:success => false} }
        format.xml  { render :xml => @subrack_name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subrack_names/1
  # PUT /subrack_names/1.xml
  def update
    @subrack_name = SubrackName.find(params[:id])

    respond_to do |format|
      if @subrack_name.update_attributes(params[:subrack_name])
          format.html { render(:json => {:success => true}) }
          format.xml  { head :ok }
      else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @subrack_name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subrack_names/1
  # DELETE /subrack_names/1.xml
  def destroy
    @subrack_name = SubrackName.find(params[:id])
    @subrack_name.destroy

    respond_to do |format|
      format.html { redirect_to(subrack_names_url) }
      format.xml  { head :ok }
    end
  end
end
