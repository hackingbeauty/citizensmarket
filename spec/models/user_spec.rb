# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe User do
  fixtures :users
  fixtures :issues

  it "has a profile picture" do
    user = create_user#valid_user
    user.profile_picture = File.open("#{RAILS_ROOT}/spec/test_images/duck.jpg")
    user.profile_picture.url.should_not be_empty
  end
  
  
  it 'loads the fixtures' do
    u = User.find(:first, :conditions => ["email = ?", 'quentin@example.com'])
    u.class.should == User
    i = Issue.find(:first, :conditions => ["name = ?", 'war'])
    i.class.should == Issue
  end

  describe 'being created' do
    before(:each) do
      @user = create_user
    end

    it 'initializes #activation_code' do
      @user.activation_code.should_not be_nil
    end

    it 'starts in pending state' do
      @user.reload
      @user.should be_pending
    end
    
    it 'requires for the user to agree on the terms of use' do
      create_user(:terms_of_use => false).errors.on(:terms_of_use).should_not be_nil
    end
    
    it 'initializes all of the issue weights and sets them all to 50' do
      @user.issue_weights.class.should == Hash
      @user.issue_weights.values.uniq.should == [50] if @user.issue_weights.class == Hash
    end
    
    it 'accepts roles as an attribute' do
      #@user = new_user(:roles => [:contributor])
      @user.roles = [:contributor]
      @user.save.should be_true
    end
    
  end

  
  describe 'interface for issue_weights' do 
    
    before(:each) do
      @user = create_user
    end
    
    #it 'updates associated user_issues as issue_weights' do
    #  @user.issue_weights = {1 => 5, 2 => 3, 3 => 0}
    #  iws = UserIssue.find(:all, :conditions => ["user_id = ?", @user.id])
    #  Hash[*iws.map{|x| [x.issue_id, x.weight]}.flatten].should == {1 => 5, 2 => 3, 3 => 0}
    #end
    
    it 'does not update any user_issues if issue_weights receives invalid data' do
      @user.issue_weights = {1 => 5, 2 => 3, 3 => -10}
      iws = UserIssue.find(:all, :conditions => ["user_id = ?", @user.id])
      
      Hash[*iws.map{|x| [x.issue_id, x.weight]}.flatten].should == {1 => 50, 2 => 50, 3 => 50}
    end
    
  end
  
  
  #
  # Validations
  #

  it 'automatically populates the login with email' do
    u = create_user(:login => nil)
    u.login.should == u.email
  end

  it 'automatically populates the login with email so there are never errors on login' do
    u = create_user(:login => nil)
    u.errors.on(:login).should be_nil
  end
  

  describe 'allows legitimate logins:' do
    ['blah@blah.com'].each do |login_str|
      it "#{login_str}" do
        lambda do
          u = create_user(:email => login_str)
          u.errors.on(:email).should     be_nil
        end.should change(User, :count).by(1)
      end
    end
  end
  describe 'disallows illegitimate emails:' do
    ['12', '1234567890_234567890_234567890_234567890_', "tab\t", "newline\n",
     "Iñtërnâtiônàlizætiøn hasn't happened to ruby 1.8 yet",
     'semicolon;', 'quote"', 'tick\'', 'backtick`', 'percent%', 'plus+', 'space '].each do |login_str|
      it "'#{login_str}'" do
          u = create_user(:email => login_str)
          u.errors.on(:email).should_not be_nil
      end
    end
  end

  it 'requires password' do
    lambda do
      u = create_user(:password => nil)
      u.errors.on(:password).should_not be_nil
    end.should_not change(User, :count)
  end

  it 'requires password confirmation' do
    lambda do
      u = create_user(:password_confirmation => nil)
      u.errors.on(:password_confirmation).should_not be_nil
    end.should_not change(User, :count)
  end

  it 'requires email' do
    lambda do
      u = create_user(:email => nil)
      u.errors.on(:email).should_not be_nil
    end.should_not change(User, :count)
  end

  describe 'allows legitimate emails:' do
    ['foo@bar.com', 'foo@newskool-tld.museum', 'foo@twoletter-tld.de', 'foo@nonexistant-tld.qq',
     'r@a.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail.com',
     'hello.-_there@funnychar.com', 'uucp%addr@gmail.com', 'hello+routing-str@gmail.com',
     'domain@can.haz.many.sub.doma.in', 'student.name@university.edu'
    ].each do |email_str|
      it "'#{email_str}'" do
        user = create_user(:email => email_str)
        user.errors.on(:email).should be_nil
      end
    end
  end
  describe 'disallows illegitimate emails' do
    ['!!@nobadchars.com', 'foo@no-rep-dots..com', 'foo@badtld.xxx', 'foo@toolongtld.abcdefg',
     'Iñtërnâtiônàlizætiøn@hasnt.happened.to.email', 'need.domain.and.tld@de', "tab\t", "newline\n",
     'r@.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail2.com',
     # these are technically allowed but not seen in practice:
     'uucp!addr@gmail.com', 'semicolon;@gmail.com', 'quote"@gmail.com', 'tick\'@gmail.com', 'backtick`@gmail.com', 'space @gmail.com', 'bracket<@gmail.com', 'bracket>@gmail.com'
    ].each do |email_str|
      it "'#{email_str}'" do
        lambda do
          u = create_user(:email => email_str)
          u.valid?
          #raise "u.errors.full_messages = #{u.errors.full_messages.inspect}"
          u.errors.on(:email).should_not be_nil
        end.should_not change(User, :count)
      end
    end
  end

  describe 'allows legitimate firstnames:' do
    ['mark'].each do |name_str|
      it "#{name_str}" do
        lambda do
          u = create_user(:firstname => name_str)
          u.errors.on(:firstname).should     be_nil
        end.should change(User, :count).by(1)
      end
    end
  end
  describe "disallows illegitimate firstnames" do
    ["tab\t", "newline\n",
     '1234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_',
     ].each do |name_str|
      it "'#{name_str}'" do
        lambda do
          u = create_user(:firstname => name_str)
          u.errors.on(:firstname).should_not be_nil
        end.should_not change(User, :count)
      end
    end
  end

  it 'can be looked up by email and password using User.authenticate' do
    User.authenticate('quentin@example.com', 'monkey').should == users(:quentin)
  end

  it 'resets password' do
    result = users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password', :terms_of_use => 1)
    User.authenticate('quentin@example.com', 'new password').should == users(:quentin)
  end

  #
  # Authentication
  #

  it 'authenticates user' do
    User.authenticate('quentin@example.com', 'monkey').should == users(:quentin)
  end

  it "doesn't authenticate user with bad password" do
    User.authenticate('quentin@example.com', 'invalid_password').should be_nil
  end

 if REST_AUTH_SITE_KEY.blank?
   # old-school passwords
   it "authenticates a user against a hard-coded old-style password" do
     User.authenticate('old_password_holder', 'test').should == users(:old_password_holder)
   end
 else
   it "doesn't authenticate a user against a hard-coded old-style password" do
     User.authenticate('old_password_holder', 'test').should be_nil
   end

   # New installs should bump this up and set REST_AUTH_DIGEST_STRETCHES to give a 10ms encrypt time or so
   desired_encryption_expensiveness_ms = 0.1
   it "takes longer than #{desired_encryption_expensiveness_ms}ms to encrypt a password" do
     test_reps = 100
     start_time = Time.now; test_reps.times{ User.authenticate('quentin', 'monkey'+rand.to_s) }; end_time   = Time.now
     auth_time_ms = 1000 * (end_time - start_time)/test_reps
     auth_time_ms.should > desired_encryption_expensiveness_ms
   end
 end

  #
  # Authentication
  #

  it 'sets remember token' do
    users(:quentin).remember_me
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
  end

  it 'unsets remember token' do
    users(:quentin).remember_me
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).forget_me
    users(:quentin).remember_token.should be_nil
  end

  it 'remembers me for one week' do
    before = 1.week.from_now.utc
    users(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
    users(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

  it 'remembers me until one week' do
    time = 1.week.from_now.utc
    users(:quentin).remember_me_until time
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
    users(:quentin).remember_token_expires_at.should == time
  end

  it 'remembers me default two weeks' do
    before = 2.weeks.from_now.utc
    users(:quentin).remember_me
    after = 2.weeks.from_now.utc
    users(:quentin).remember_token.should_not be_nil
    users(:quentin).remember_token_expires_at.should_not be_nil
    users(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

  it 'registers passive user' do
    user = create_user(:password => nil, :password_confirmation => nil)
    user.should be_passive
    user.password = 'new password'
    user.password_confirmation = 'new password'
    user.register!
    user.should be_pending
  end

  it 'suspends user' do
    users(:quentin).suspend!
    users(:quentin).should be_suspended
  end

  it 'does not authenticate suspended user' do
    users(:quentin).suspend!
    User.authenticate('quentin', 'monkey').should_not == users(:quentin)
  end

  it 'deletes user' do
    users(:quentin).deleted_at.should be_nil
    users(:quentin).delete!
    users(:quentin).deleted_at.should_not be_nil
    users(:quentin).should be_deleted
  end

  describe "being unsuspended" do
    fixtures :users

    before do
      @user = users(:quentin)
      @user.suspend!
    end

    it 'reverts to active state' do
      @user.unsuspend!
      @user.should be_active
    end

    it 'reverts to passive state if activation_code and activated_at are nil' do
      User.update_all :activation_code => nil, :activated_at => nil
      @user.reload.unsuspend!
      @user.should be_passive
    end

    it 'reverts to pending state if activation_code is set and activated_at is nil' do
      User.update_all :activation_code => 'foo-bar', :activated_at => nil
      @user.reload.unsuspend!
      @user.should be_pending
    end
  end

protected
  def create_user(options = {})
    record = new_user(options)
    record.register! if record.valid?
    #raise "record.id is nil and errors = #{record.errors.full_messages.join(', ')}" if record.id.nil?
    record
  end
  
  def new_user(options = {})
    User.new(valid_user_params.merge(options))
  end
  
  def valid_user_params
    {
      :firstname=> 'mark', 
      :lastname=>'muskardin', 
      :email => 'quire@example.com', 
      :password => 'quire69', 
      :password_confirmation => 'quire69', 
      :terms_of_use => "1" 
    }
  end
  
end
