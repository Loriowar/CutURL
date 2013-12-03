class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale_from_subdomain

  # Functions for identify locale
  def set_locale_from_params
    # Get locale from request parameters
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_locale_from_subdomain
    # Get locale from Subdomain Name
    # (locale from params add for testing and for heroku)
    I18n.locale = extract_locale_from_subdomain || params[:locale] || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    unless parsed_locale.nil?
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    end
  end


  def not_found
    render 'not_found'
    # raise ActionController::RoutingError.new('Not Found')
  end


  # Helpers for other controllers
  def construct_url_for_redirect(short_name)
    # Regexp needed for detect locale from subdomain, when server run locally
    # (i.e. for work with links like "en.application.localhost:3000")
    'http://' << (request.host =~ /localhost/ ? request.host_with_port : request.host) << '/' << short_name
  end

end
