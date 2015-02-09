require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  

  has_one :profile
  has_many :articles,
                      :dependent => :nullify
  has_many :replies, :through => :articles, :source => :comments

  validates :email, :uniqueness => { :case_sensitive => false }
  before_save :encrypt_new_password

  mount_uploader :avatar, AvatarUploader

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end

  protected
    def encrypt_new_password
      return if password.blank?
      self.hashed_password = encrypt(password)
    end

    def password_required?
      hashed_password.blank? || password.present?
    end

    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
end
