# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:email], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag

      session[:login_status] = "success"
      flash[:message] = "You have successfully logged in."
      respond_to do |format|
        format.html {
          redirect_to dashboard_url
          return
        }
        format.json {render :json => 'success'}
        # format.js
      end
    else
      flash[:message] = "<p class=\"login-error\">That won&#39;t work!</p><p>You entered a wrong username and/or password.</p>"
      session[:login_status] = "failure"
      respond_to do |format|
        format.html {
          redirect_to login_url
          return
        }
        format.json {render :json => 'failure'}
        # format.js
      end
      #note_failed_signin
      #@login       = params[:login]
      #@remember_me = params[:remember_me]
    end
  end

  def destroy
    logout_killing_session!
    # flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  protected
    # Track failed login attempts
    def note_failed_signin
      # what is this function?  Why would there be a params[:firstname] passed in during a login attempt?
      #flash[:message] = "Couldn't log you in as '#{params[:firstname]}'"
      logger.warn "Failed login for '#{params[:email]}' from #{request.remote_ip} at #{Time.now.utc}"
    end
end
