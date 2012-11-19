class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :password, :username, :resume_file
  
  #validates :name, :email, :username, :presence => true, :on => :update
  #validates :username, :uniqueness => true#, :exclusion => [""]
  #validates_confirmation_of :password
  #validates_presence_of :password, :on => :create
  
  validates_presence_of :name, :email, :password, :username, :on => :create, :if => :just_added
  validates_presence_of :name, :email, :password, :username, :on => :update
  validates_uniqueness_of :username, :on => :create, :if => :just_added
  
  #validates :name, :email, :password, :username,, :presence => true, :if => :stuff
  
  has_one :resume
  
  attr_accessor :password, :resume_file, :newly_created
  
  before_save :encrypt_password
  
  #def to_param
  #  username
  #end
  
  def just_added
    !newly_created
  end
  
  def self.authenticate(username, email, password)
    user = find_by_username(username)
    if user.nil? 
       user = find_by_email(email)
    end
    
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
    else
      nil
    end
  end

  def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
  end
  
end
