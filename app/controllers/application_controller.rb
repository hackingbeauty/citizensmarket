# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  # helper_method :current_user, :logged_in?

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '63aceb3c6a00684ec018ed89c58d21b4'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  protected

    def permission_denied
      session[:attempted_request] = {}
      session[:attempted_request][:uri] = request.request_uri
      session[:attempted_request][:params] = params
      #session[:protected_page] = request.request_uri
      #session[:protected_params] = params
      flash[:message] = CmSnippets.not_authorized_message
      redirect_to login_url
    end

    def cm_redirect_back_or(path)
      if session[:attempted_request].nil?
        redirect_to path
      else
        u = session[:attempted_request][:uri]
        p = session[:attempted_request][:params]
        session[:attempted_request] = nil
        redirect_to u, p
      end
    end

    # Protect a page from unauthorized access.
    #	def admin_login_required
    #	  unless admin_logged_in?
    #	    session[:protected_page] = request.request_uri
    #	    redirect_to :controller => "admin", :action => "login"
    #	    return false
    #    end
    #  end

end
