class UserObserver < ActiveRecord::Observer
  def after_create(user)
    unless ["cucumber", "test"].include?(RAILS_ENV)
      UserMailer.deliver_signup_notification(user) unless user.role_symbols.include?(:admin)
    end
  end

  def after_save(user)
    # UserMailer.deliver_activation(user) if user.recently_activated?
    UserMailer.deliver_reset_notification(user) if user.recently_reset?
  end
end
