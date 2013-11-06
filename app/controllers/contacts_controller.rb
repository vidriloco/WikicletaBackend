class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])
    
    @contact.save
    
    respond_to do |format|
      format.js
    end
  end
end
