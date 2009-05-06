class AdminController < ApplicationController
  
def login
  if request.post? and params[:admin]
    @admin = Admin.new(params[:admin])
    admin = Admin.find_by_email_and_password(@admin.email,@admin.password)
    if admin
      session[:user_id] = admin.id
      flash[:notice] = "Admin #{admin.email} logged in!"
      redirect_to :controller => "companies", :action => "administer"
    else
      #Don't show the password in the view
      @admin.password = nil
      flash[:notice] = "Invalid email/password combination"
    end
  end
end

end

