class Sticker < ActiveRecord::Base
  include Shared::Categories
    
  attr_accessor :lat, :lon
  attr_accessible :status, :fake, :banned, :details, :code, :lat, :lon, :email
    
  before_validation :build_location
  before_validation :initialize_code_and_status, :on => :create
  
  validates :code, :uniqueness => true
  validates :location, :presence => true
  
  def stored_lat
    return nil if self.location.nil?
    self.location.latitude
  end
  
  def stored_lon
    return nil if self.location.nil?
    self.location.longitude
  end
  
  def available?
    self.status == Sticker.category_for(:statuses, :available)
  end
  
  def claimed?
    self.status == Sticker.category_for(:statuses, :claimed)
  end
  
  def status_to_sym
    Sticker.category_symbol_for(:statuses, status)
  end
  
  protected
  
  def initialize_code_and_status
    self.code = SecureRandom.hex 2
    self.status = Sticker.category_for(:statuses, :available)
  end
  
  def build_location
    self.location = "POINT(#{lon} #{lat})"
  end
  
  def self.statuses
    { 1 => :available, 2 => :claimed }
  end
end
