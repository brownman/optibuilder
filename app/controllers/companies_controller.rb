class CompaniesController < ApplicationController
  # GET /companies/store/id
  # JSON
   def store
      if params[:id] == "grid"
        list = []
        conditions = ""
        conditions = ["name LIKE ?", "%#{params[:query]}%"] if params[:query]
        companies = Company.all(
                                :conditions => conditions,
                                :limit => params[:limit],
                                :offset => params[:start],
                                :order => "name"
                        )
        total = Company.count(:conditions => conditions)
        render(:json => {:success => true, :root => companies, :totalCount => total})

      end
   end
  # GET /companies
  # GET /companies.xml

  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    @address = @company.address
  end

  # POST /companies
  # POST /companies.xml
  def create
    Company.transaction do
      begin
        @company = Company.new(params[:company])
        @company.address = Address.new(params[:address])

        respond_to do |format|
          if @company.save

            format.html { render :json => {:success => true} }
            format.xml  { render :xml => @company, :status => :created, :location => @company }
          else
            format.html { render :json => ( (@company.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @company.errors.empty?
            format.html { render :json => {:success => false} }
            format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
          end
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    Company.transaction do
      begin
        @company = Company.find(params[:id])
        respond_to do |format|
          if @company.update_attributes(params[:company])
            @company.address.update_attributes(params[:address])
            format.html { render(:json => {:success => true}) }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
          end
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
end
