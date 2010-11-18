class SitesAdditionalInformationsController < ApplicationController
  # GET /sites_additional_informations
  # GET /sites_additional_informations.xml
  def index
    @sites_additional_informations = SitesAdditionalInformation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sites_additional_informations }
    end
  end

  # GET /sites_additional_informations/1
  # GET /sites_additional_informations/1.xml
  def show
    @sites_additional_information = SitesAdditionalInformation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sites_additional_information }
    end
  end

  # GET /sites_additional_informations/new
  # GET /sites_additional_informations/new.xml
  def new
    @sites_additional_information = SitesAdditionalInformation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sites_additional_information }
    end
  end

  # GET /sites_additional_informations/1/edit
  def edit
    @sites_additional_information = SitesAdditionalInformation.find(params[:id])
  end

  # POST /sites_additional_informations
  # POST /sites_additional_informations.xml
  def create
    @sites_additional_information = SitesAdditionalInformation.new(params[:sites_additional_information])

    respond_to do |format|
      if @sites_additional_information.save
        format.html { redirect_to(@sites_additional_information, :notice => 'SitesAdditionalInformation was successfully created.') }
        format.xml  { render :xml => @sites_additional_information, :status => :created, :location => @sites_additional_information }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sites_additional_information.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sites_additional_informations/1
  # PUT /sites_additional_informations/1.xml
  def update
    @sites_additional_information = SitesAdditionalInformation.find(params[:id])

    respond_to do |format|
      if @sites_additional_information.update_attributes(params[:sites_additional_information])
        format.html { redirect_to(@sites_additional_information, :notice => 'SitesAdditionalInformation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sites_additional_information.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sites_additional_informations/1
  # DELETE /sites_additional_informations/1.xml
  def destroy
    @sites_additional_information = SitesAdditionalInformation.find(params[:id])
    @sites_additional_information.destroy

    respond_to do |format|
      format.html { redirect_to(sites_additional_informations_url) }
      format.xml  { head :ok }
    end
  end
end
