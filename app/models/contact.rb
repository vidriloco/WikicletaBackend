class Contact < ActiveRecord::Base
  validates :email, :presence => true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
end
