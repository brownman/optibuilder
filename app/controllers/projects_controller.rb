class ProjectsController < ApplicationController
  # GET /projects/store/id
  # JSON
   def store
      if params[:id] == "grid"
        list = []
        if session_user.id == 1
            conditions = ""
            conditions = ["projects.name LIKE ? OR description LIKE ? OR companies.name LIKE ?",
                         "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
        else
            conditions = "projects.id in (select project_id from users_projects where user_id = "+session_user.id.to_s+")"
            conditions = ["projects.name LIKE ? OR description LIKE ? OR companies.name LIKE ? and projects.id in (select project_id from users_projects where user_id = "+session_user.id.to_s+")",
                         "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"] if params[:query]
        end
        projects = Project.all(:select =>  "projects.*
                                           ,companies.name AS companies_name",
                               :joins => [:customer, :owner],
                               :conditions => conditions,
                               :limit => params[:limit],
                               :offset => params[:start],
                               :order => "projects.name"
        )
        list
        total = Project.count(:joins => [:customer, :owner], :conditions => conditions)
        render(:json => {:success => true, :root => projects, :totalCount => total})
      end
   end

  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @sites = @project.spans

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    Project.transaction do
      begin
        users_projects = ActiveSupport::JSON.decode(params[:users_projects]) if params[:users_projects]
        params[:project]["has_test_attenuation_1310"] = false unless params[:project]["has_test_attenuation_1310"]
        params[:project]["has_test_attenuation_1550"] = false unless params[:project]["has_test_attenuation_1550"]
        params[:project]["has_test_otdr_standard"] = false unless params[:project]["has_test_otdr_standard"]
        params[:project]["has_test_otdr_premium"] = false unless params[:project]["has_test_otdr_premium"]
        params[:project]["has_test_pmd_10_min"] = false unless params[:project]["has_test_pmd_10_min"]
        params[:project]["has_test_pmd_60_min"] = false unless params[:project]["has_test_pmd_60_min"]
        params[:project]["has_test_chromatic"] = false unless params[:project]["has_test_chromatic"]
        params[:project]["has_test_orl"] = false unless params[:project]["has_test_orl"]
        params[:project]["has_test_site_survey"] = false unless params[:project]["has_test_site_survey"]
        respond_to do |format|
          @project = Project.new(params[:project])
          if users_projects
            users_projects.each do |u|
              if u["id"].to_i == 0
                new_user = User.new
                new_user.name = u['name']
                new_user.company_description = u['company_description']
                new_user.contact_phone = u['contact_phone']
                new_user.comments = u['comments']
                new_user.company_id = @project.customer_id
                new_user.save(false) #Saving without validation
                @project.users_projects << UsersProject.new(:user_id => new_user.id, :role => u["role_id"])
              else
                @project.users_projects << UsersProject.new(:user_id => u["id"], :role => u["role_id"])
              end
            end
          end
          if @project.save
            format.html { render :json => {:success => true} }
            format.xml  { render :xml => @project, :status => :created, :location => @project }
          else
            format.html { render :json => ( (@project.errors.full_messages.join(".<br />").to_s + ".").to_json ) } unless @project.errors.empty?
            format.html { render :json => {:success => false} }
            format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
          end
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end


  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    Project.transaction do
      begin
        @project = Project.find(params[:id])
        users_projects = ActiveSupport::JSON.decode(params[:users_projects]) if params[:users_projects]

        params[:project]["has_test_attenuation_1310"] = false unless params[:project]["has_test_attenuation_1310"]
        params[:project]["has_test_attenuation_1550"] = false unless params[:project]["has_test_attenuation_1550"]
        params[:project]["has_test_otdr_standard"] = false unless params[:project]["has_test_otdr_standard"]
        params[:project]["has_test_otdr_premium"] = false unless params[:project]["has_test_otdr_premium"]
        params[:project]["has_test_pmd_10_min"] = false unless params[:project]["has_test_pmd_10_min"]
        params[:project]["has_test_pmd_60_min"] = false unless params[:project]["has_test_pmd_60_min"]
        params[:project]["has_test_chromatic"] = false unless params[:project]["has_test_chromatic"]
        params[:project]["has_test_orl"] = false unless params[:project]["has_test_orl"]
        params[:project]["has_test_site_survey"] = false unless params[:project]["has_test_site_survey"]

        respond_to do |format|
          if @project.update_attributes(params[:project])
            if users_projects
              @project.users_projects.delete_all #Delete all previous data

              users_projects.each do |u|
                if u["user_id"].to_i == 0
                  new_user = User.new
                  new_user.name = u['user_name']
                  new_user.company_description = u['company_description']
                  new_user.contact_phone = u['contact_phone']
                  new_user.comments = u['comments']
                  new_user.company_id = @project.customer_id
                  new_user.save(false) #Saving without validation
                  @project.users_projects << UsersProject.new(:user_id => new_user.id, :role => u["role_id"])
                else
                  @project.users_projects << UsersProject.new(:user_id => u["user_id"], :role => u["role_id"])
                end
              end
            end
            format.html { render(:json => {:success => true}) }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
          end
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    Project.transaction do
      begin
        @project = Project.find(params[:id])
        @project.users_projects.delete_all
        @project.destroy
      rescue
        raise ActiveRecord::Rollback
      end
    end
    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end