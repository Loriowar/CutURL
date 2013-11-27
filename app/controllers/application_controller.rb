class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale_from_subdomain

  def set_locale_from_params
    # Get locale from request parameters
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_locale_from_subdomain
    # Get locale from Subdomain Name (locale from params add for testing and for heroku)
    I18n.locale = extract_locale_from_subdomain || params[:locale] || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    unless parsed_locale.nil?
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    end
  end

  def not_found
    render partial: 'not_found'
    # raise ActionController::RoutingError.new('Not Found')
  end
end
