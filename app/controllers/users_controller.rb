class UsersController < ApplicationController

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
  
  before_filter :login_required, :only => [:edit, :update]

  # render new.rhtml
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])      
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if verify_recaptcha(@user) && success && @user.errors.empty?
      flash[:notice] = "<p class=\"big\">Thanks for signing up!</p><p>We're sending you an email to #{@user.email} with your activation code.</p>"
      redirect_back_or_default('/')
    else
      render :template => '/home/show'
    end
  end
  
  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:id]) unless params[:id].blank?
    case
    when (!params[:id].blank?) && user && !user.active?
      user.activate!
      flash[:message] = "<p class=\"big\">Signup complete!</p><p>Please sign in to continue.</p>"
      redirect_to '/login'
    when params[:id].blank?
      flash[:error] = "<p>The activation code was missing.  Please follow the URL from your email.</p>"
      redirect_back_or_default('/')
    else
      flash[:error]  = "<p>We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in.</p>"
      redirect_back_or_default('/')
    end
  end

  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        flash[:forgot_password_notice] = "<p class='green'>Password reset code has been sent to #{user.email}</p>"
      else
        flash[:forgot_password_notice] = "<p class='red'>The email address #{params[:user][:email]} does not exist in system</p>"
      end
      render :template => '/users/forgot'
    end
  end
  
  def reset
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?
    logger.info('reset code is ' + params[:reset_code])
    if request.post?
      if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        self.current_user = @user
        @user.delete_reset_code
        render :template => '/users/dashboard'
      else
        flash[:notice] = "<p class='red'>I'm sorry, but I can't reset the password for #{@user.email}</p>"
        render :action => :reset
      end
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
    @user = current_user
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
