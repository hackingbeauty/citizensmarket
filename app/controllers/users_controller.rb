class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]

  def change_password
    
  end
  
  def update_password
    
    if User.authenticate(current_user.login, params[:old_password])
      @user = current_user
      if @user.update_attributes(:password => params[:password], :password_confirmation => params[:password_confirmation])
        flash[:notice] = 'Your password has been updated'
        redirect_to user_path(@user)
      else
        flash.now[:alert] = 'Was unable to update password: most likely your passwords did not match.'
        render :action => 'change_password'
      end
    else
      flash.now[:alert] = 'Authentication failed: incorrect old password (this message should be changed)'
      render :action => 'change_password'
    end
  end

  # render new.rhtml
  def new
    @user = User.new
  end
  
  def edits
    @user = User.find(params[:id])
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])      
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_back_or_default('/')
    else
      
      # flash[:error]  = "#{@user.errors[0]} We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      @user.errors do |error|
        flash[:error] += error
      end
      
      # flash[:error] = @user.errors.add :email
      #   flash[:error] = @user.errors.add :password
      
      # render :controller => 'home', :action => 'show'
      redirect_to :controller => 'home', :action=>'show'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:id]) unless params[:id].blank?
    case
    when (!params[:id].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:id].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend!
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend!
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  def show
    @user = find_user
  end
  
  def update
    
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your user profile has been updated!"
      respond_to do |format|
        format.html {redirect_to :action => 'show'}
      end
    else
      flash.now[:error] = "There were some errors in your input."
      respond_to do |format|
        format.html {render :action => 'edit'}
      end
    end
  end
  
  # shouldn't this be called "update issue weights"?
  def issue_weights
    @user = find_user
    # Only update if the user being updated is the one that is logged in
    @user.update_issue_weights(params) if current_user == @user
    redirect_to user_url(@user)
  end

  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user ||= User.find(params[:id])
  end
end
