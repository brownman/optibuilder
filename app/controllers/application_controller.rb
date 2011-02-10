# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #helper :all # include all helpers, all the time
  before_filter :authorize, :except => :authenticate
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :session_user

  def session_user
    @session_user ||= User.find(session[:user_id])
  end

  protected
  def authorize
    unless session[:user_id]
      flash[:notice] = 'Please efetue log in'
      redirect_to :controller => 'login', :action => 'login'
    end
  end

  def get_token
    "abc"+Time.now.strftime("%d%m%Y").to_s
  end

  def verify_token(tkn)
    if tkn.to_s == "abc"+Time.now.strftime("%d%m%Y").to_s
      return true
    else
      return false
    end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
