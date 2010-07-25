class User < ActiveRecord::Base
  has_and_belongs_to_many :books
  has_many :reviews

  attr_accessor :password, :password_confirmation
  attr_protected :password_salt


  acts_as_tagger
  
  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_presence_of :login, :email
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"

  def password=(pass)
    @password = pass
    self.password_salt = User.random_string(10) if !self.password_salt?
    self.password_hash = User.hash_password(@password, self.password_salt)
  end

  def self.authenticate(login, pass)
    u = find(:first, :conditions => ["login = ?", login])
    return nil if u.nil?
    return u if User.hash_password(pass, u.password_salt) == u.password_hash
    nil
  end
  
  protected

  def self.hash_password(pass, password_salt)
    Digest::SHA1.hexdigest(pass + password_salt)
  end

  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
  def self.number_of_users_exceeded?
    num = User.find_by_sql("select count(*) number from users")[0].number.to_i
    if num > 99
      true
    else
      false
    end
  end
end
