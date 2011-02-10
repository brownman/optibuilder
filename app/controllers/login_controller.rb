class LoginController < ApplicationController

  before_filter :authorize, :except => [:authenticate, :login]
#  layout "optibuilder", :except => :login

  def login

  end

  def authenticate
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:login], params[:password])
      if user
        roles = []
        session[:user_id] = user.id
        user.users_projects.each do |p|
          roles << { :project_id => p.project_id, :role_id => p.role }
        end
        session[:roles] = roles
        redirect_to :controller => "home"
        flash[:notice] = nil
      else
        flash[:notice] = "Invalid user/password combination"
        render :login
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:new_perms] = nil
    session[:user_map_enabled] = nil
    flash[:notice] = "Logged out"
    redirect_to :action => "login"
  end

end
