require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  has_many :reviews
  has_many :user_issues
  has_many :issues, :through => :user_issues
  has_many :peer_ratings
  
  serialize :profile, Hash

  before_validation :copy_email_to_login

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message



  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :profile, :issue_weights

  after_create{ |user|
    for issue in Issue.find(:all)
      UserIssue.create!(:user_id => user.id, :issue_id => issue.id, :weight => 1.0)
    end
    user.activate
    user.save
  }


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected

    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end

  def copy_email_to_login
    if self.email != self.login and ! self.deleted?
      #only do this on change
      unless self.login.nil?
        @requires_reactivation=true
        make_activation_code
        self.activated_at=nil
      end
      self.login=self.email
    end
  end

end
