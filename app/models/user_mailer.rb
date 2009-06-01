class UserMailer < ActionMailer::Base
  
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
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
      @subject     = "[CitizensMarket] "
      @sent_on     = Time.now
      @body[:user] = user
    end
    
end
