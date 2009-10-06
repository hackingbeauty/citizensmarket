class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_signup_notification(user) unless user.role_symbols.include?(:admin)
  end

  def after_save(user)
    # UserMailer.deliver_activation(user) if user.recently_activated?
    UserMailer.deliver_reset_notification(user) if user.recently_reset?
  end
end
