class Workshop < ActiveRecord::Base
  include Geography
  include Queries
  include Api
  include Dumpable
  
  validates_presence_of :name, :details

  has_many :ownerships, :as => :owned_object, :dependent => :destroy
  has_many :favorites, :as => :favorited_object, :dependent => :destroy
  has_many :ranked_comments, :as => :ranked_comment_object, :dependent => :destroy
  
  has_many :users, :through => :ownerships
  
  default_scope order('updated_at DESC')
  
  def store?
    store
  end 
  
  def identifier
    "workshop-#{id}"
  end
  
  def as_json(opts={})
    super({
      :only => [:id, :name, :details, :likes_count, :dislikes_count, :store, :phone, :cell_phone, :webpage, :twitter, :horary, :others_can_edit_it],
      :methods => [:str_created_at, :str_updated_at, :lat, :lon, :owner]
    })
  end
  
  def self.new_with(params, coords, user)
    workshop=Workshop.new(params)
    workshop.apply_geo(coords)
    workshop.ownerships.build(:user => user, :owned_object => workshop, :kind => Ownership.category_for(:owner_types, :submitter))
    workshop
  end
  
  def update_with(params, coordinates)
    self.apply_geo(coordinates)
    self.update_attributes(params)
  end
  
  def light_description
    details
  end
  
  def light_title
    name
  end
  
  def self.attrs_for_dump
    %w(name details store phone cell_phone webpage twitter horary likes_count updated_at created_at)
  end
  
  def self.attrs_for_dump_ex
    %w(coordinates_to_s)
  end

end
