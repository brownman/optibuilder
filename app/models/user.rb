require 'digest/sha1'

class User < ActiveRecord::Base

  belongs_to :company
  has_many :users_projects
  has_many :projects, :through => :users_projects
  has_many :users_logs

  validates_presence_of :name, :login
  validates_presence_of :hashed_password, :message => "Missing password"
  validates_uniqueness_of :name, :login

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  def status_name
    return read_attribute(:status) if read_attribute(:status).nil? or not read_attribute(:status).to_i
    att =  '-'
    case read_attribute(:status).to_i
      when 1
        att = 'Valid'
      when 2
        att = 'Invalid'
      when 3
        att = 'Locked'
    end
  end

  # 'password' is a virtual attribute
  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank? or nil
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(login, password)
    user = self.find_by_login(login)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "rubyrox:-)" + salt # 'rubyrox:-)' makes it hard to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
