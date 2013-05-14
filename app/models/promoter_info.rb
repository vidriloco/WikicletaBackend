class PromoterInfo < ActiveRecord::Base
  has_many :promoteds
  
  def address_h
    address.blank? ? I18n.t('promoteds.views.show.address_not_given') : address
  end
  
  def contact_info_h
    contact_info = (email.blank? ? I18n.t('promoteds.views.show.email_not_given') : email)
    contact_info << " - "
    contact_info << (phone.blank? ? I18n.t('promoteds.views.show.phone_not_given') : phone)
  end
end
