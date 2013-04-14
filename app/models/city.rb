class City < ActiveRecord::Base
  has_many :users

  def name
    I18n.t("cities.#{code}")
  end
end
