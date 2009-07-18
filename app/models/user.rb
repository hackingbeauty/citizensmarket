require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles
  is_gravtastic
    
  after_create :initialize_default_issue_weights
  after_destroy :destroy_user_issue_weights

  has_many :reviews
  has_many :user_issues
  has_many :issues, :through => :user_issues
  has_many :peer_ratings
  
  serialize :profile, Hash

  before_validation :copy_email_to_login
  
  # validates_presence_of     :login
  # validates_length_of       :login,    :within => 3..40
  # validates_uniqueness_of   :login
  # validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message
  # 
  validates_format_of       :firstname,    :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => false
  validates_length_of       :firstname,    :maximum => 100, :allow_nil => false
  validates_format_of       :lastname,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => false
  validates_length_of       :lastname,     :maximum => 100, :allow_nil => false

  # Max & min lengths for all fields
  FIRSTNAME_MAX_LENGTH = 100
  LASTNAME_MAX_LENGTH = 100
  EMAIL_MAX_LENGTH = 100
  PASSWORD_MIN_LENGTH = 6
	PASSWORD_MAX_LENGTH = 40
	PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
	
	# Text box sizes for display in the views
	FIRSTNAME_SIZE = 20
	LASTNAME_SIZE = 20
	EMAIL_SIZE = 20
	PASSWORD_SIZE = 20

  validates_presence_of     :email
  validates_length_of       :email,    :maximum => EMAIL_MAX_LENGTH
  validates_uniqueness_of   :email
	validates_format_of       :email,
				  :with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
				  :with => Authentication.email_regex, :message => Authentication.bad_email_message
	validates_acceptance_of   :terms_of_use,
                            :allow_nil => false, :on => :create

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation, :profile, :issue_weights, :terms_of_use

  after_create{ |user|
    for issue in Issue.find(:all)
      UserIssue.create!(:user_id => user.id, :issue_id => issue.id, :weight => 1.0)
    end
    # user.activate
    user.save
  }

  ##########################################################
  ######## SCORING SYSTEM
  
  # moved to lib/cm_scores.rb  - Luke, 
  # can remove this message/section from this file eventually
  
  ######## end SCORING SYSTEM
  ########d##################################################

  def has_rated(review)
    {PeerRating => true, NilClass => false}[PeerRating.find(:first, :conditions => "review_id = #{review.id} and user_id = #{id}").class]
  end
  
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:email => email} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def initialize_default_issue_weights
    UserIssue.delete_all(:user_id => self.id)
    UserIssue.create(
      Issue.all.map { |issue| { :user_id => self.id, 
                                :issue_id => issue.id, 
                                :weight => 50}})
  end
  
  def issue_weight(issue)
    user_issues.find_by_issue_id(issue).weight
  end
  
  def update_issue_weights(params)
    params.each do |key, value|
      next unless key[0..5] == "issue_"
      UserIssue.update_all("weight = #{value.to_i}", "user_id = #{self.id} AND issue_id = #{key[6..8].to_i}")
    end
  end
  
  # Methods to return seralized profile attributes
  def location
    return nil if profile.nil?
    profile[:location]
  end
  
  def website
    return nil if profile.nil?
    profile[:website]
  end
  
  def website=(value)
    return nil if profile.nil?
    profile[:website] = value
  end

  def create_reset_code
    @reset = true
    self.reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    logger.info('inside create_reset code = ' + self.reset_code)
    save(false)
  end
  
  def recently_reset?
    @reset
  end
 
  def delete_reset_code
    self.reset_code = nil
    save(false)
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
  
  def destroy_user_issue_weights
    UserIssue.delete_all(:user_id => self.id)
  end
  
end
