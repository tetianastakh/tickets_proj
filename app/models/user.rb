class User < ActiveRecord::Base
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    :message => "InvalidEmail" }, presence: true, uniqueness: { message: "EmailAlreadyInUse" }, :if => :email_changed?
  validates :password, :format => { :with => /(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?=.{8,})/,
    :message => "InvalidPassword"}, presence: true

  has_secure_password
end
