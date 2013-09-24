class AdminUser < ActiveRecord::Base
  include Dumpable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  #temporal
  attr_accessible :encrypted_password, :created_at, :updated_at, :sign_in_count, :last_sign_in_at, :current_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :authentication_token
  
  def self.attrs_for_dump
    %w(email encrypted_password reset_password_token reset_password_sent_at remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip created_at updated_at)
  end
  
  def self.attrs_for_dump_ex
    []
  end

end
