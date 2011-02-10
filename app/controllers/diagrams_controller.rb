class DiagramsController < ApplicationController
   def store
      if params[:id] == "grid"
         list = []
         conditions = ""
         conditions = ["name LIKE ?", "%#{params[:query]}%"] if params[:query]
         diagrams = Diagram.all(:conditions => conditions,
                          :limit => params[:limit],
                          :offset => params[:start],
                          :order => "name")
         total = User.count(:conditions => conditions)
         render(:json => {:success => true, :root => diagrams, :totalCount => total})
      end
   end
  # GET /Diagrams
  # GET /Diagrams.xml

  def preview
    @qty = params[:qty].to_i
    @rows = params[:rows].to_i
    @cols = params[:cols].to_i

    return render(:partial => 'preview', :locals => { :qty => @qty, :rows => @rows, :cols => @cols })
  end

  def index
    @Diagrams = Diagram.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @Diagrams }
    end
  end

  # GET /Diagrams/1
  # GET /Diagrams/1.xml
  def show
    @diagram = Diagram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diagram }
    end
  end

  # GET /Diagrams/new
  # GET /Diagrams/new.xml
  def new
    @diagram = Diagram.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diagram }
    end
  end

  # GET /Diagrams/1/edit
  def edit
    @diagram = Diagram.find(params[:id])
  end

  # POST /Diagrams
  # POST /Diagrams.xml
  def create
    @diagram = Diagram.new(params[:diagram])
    respond_to do |format|
      if @diagram.save
        format.html { render :json => {:success => true} }
        format.xml  { render :xml => @diagram, :status => :created, :location => @diagram }
      else
        format.html { render :json => ( (@diagram.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @diagram.errors.empty?
        format.html { render :json => {:success => false} }
        format.xml  { render :xml => @diagram.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Diagrams/1
  # PUT /Diagrams/1.xml
  def update
     @diagram = Diagram.find(params[:id])
     respond_to do |format|
     if @diagram.update_attributes(params[:diagram])
        format.html { render(:json => {:success => true}) }
        format.xml  { head :ok }
     else
        format.html { render :action => "edit" }
       format.xml  { render :xml => @diagram.errors, :status => :unprocessable_entity }
     end
    end
  end

  # DELETE /Diagrams/1
  # DELETE /Diagrams/1.xml
  def destroy
    @diagram = Diagram.find(params[:id])
    @diagram.destroy
    respond_to do |format|
      format.html { redirect_to(diagrams_url) }
      format.xml  { head :ok }
    end
  end
end
