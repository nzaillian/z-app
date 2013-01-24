class User < ActiveRecord::Base

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :email, :presence => true, 
            :format => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, 
            :uniqueness => true

  validates :first_name, :presence => true
  validates :last_name, :presence => true
end