class LanguagesController < ApplicationController
  def update
    I18n.locale = params[:id] || I18n.default_locale
    redirect_to :back
  end
end