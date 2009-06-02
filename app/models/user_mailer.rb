class UserMailer < ActionMailer::Base
  
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Welcome!  Please activate your new Citizens Market account'
    # @body[:url]  = "http://staging.citizensmarket.org/activate/#{user.activation_code}"
    @body[:url]  = "http://#{SITE_URL}/activate/#{user.activation_code}"
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    # @body[:url]  = "http://staging.citizensmarket.org/"
    @body[:url]  = "http://#{SITE_URL}/"
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    # @body[:url]  = "http://staging.citizensmarket.org/"
    @body[:url]  = "Your password is: #{user.password}"
  end
  
  def reset_notification(user)
    setup_email(user)
    @subject    += 'Link to reset your password'
    @body[:url]  = "http://#{SITE_URL}/reset/#{user.reset_code}"
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "no-reply@citizensmarket.org"
      @subject     = ""
      @sent_on     = Time.now
      @body[:user] = user
    end
    
end
