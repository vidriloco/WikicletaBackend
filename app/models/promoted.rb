class Promoted < ActiveRecord::Base
  include Likes
  
  acts_as_commentable
  
  has_many :user_like_promoteds, :dependent => :destroy
  belongs_to :promoter_info
  has_many :pictures, :as => :imageable, :dependent => :destroy
  
  validates_presence_of :promoter_info, :headline

  def self.fetch_all(user)
    if user.nil? || user.city.nil?
      Promoted.all
    else
      # test this case for promoter_info's with unset city
      Promoted.joins(:promoter_info).
      joins("LEFT JOIN promoter_infos ON promoter_infos.city_id = cities.id").where('promoter_info.city_id' => user.city_id)
    end
  end
  
  def self.most_popular(user)
    if user.nil? || user.city.nil?
      order('likes_count DESC')
    else
      # test this case for promoter_info's with unset city
      Promoted.joins(:promoter_info).
      joins("LEFT JOIN promoter_infos ON promoter_infos.city_id = cities.id").order('likes_count DESC').where('promoter_info.city_id' => user.city_id)
    end
  end
  
  def promoter_name
    promoter_info.name
  end
  
  def city_name
    city.name unless city.nil?
  end
end
