class AdminController < ApplicationController

  def login
    if request.post? and params[:admin]
      @admin = Admin.new(params[:admin])
      admin = Admin.find_by_email_and_password(@admin.email,@admin.password)
      if admin
        session[:admin_id] = admin.id
        flash[:notice] = "Admin #{admin.email} logged in!"
        if logged_in?
          logout_killing_session!
          flash[:notice] += " You were logged in as a mere mortal. You have been logged out from your nonadmin account."
        end
        redirect_back_or_default(:controller => "companies", :action => "administer")
      else
        #Don't show the password in the view
        @admin.password = nil
        flash[:notice] = "Invalid email/password combination"
      end
    end
  end

end
