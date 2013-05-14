class City < ActiveRecord::Base
  has_many :users

  def name
    I18n.t("cities.list.#{code}")
  end
end
