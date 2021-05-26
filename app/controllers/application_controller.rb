class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale
  before_action :set_theme
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :update_user_online, if: :user_signed_in?

  helper_method :favorite_text
  # protect_from_forgery   # if enable -> not login with local email/username

  def set_theme
    if params[:theme].present?
      theme = params[:theme].to_sym
      # session[:theme] = theme
      cookies[:theme] = theme
      redirect_to(request.referrer || root_path)
    end
  end

  def default_url_options
    return {} if I18n.locale == I18n.default_locale

    { lang: I18n.locale }
  end

  def favorite_text
    return @favorite_exists ?  "&#x2764;&#xfe0f;".html_safe : "&#x2661;".html_safe
  end

  def set_locale
    if user_signed_in? && !current_user&.language.blank?
      I18n.locale = current_user.language
    else
      extract_cookies_locale unless cookies[:my_locale].blank?

      I18n.locale = extract_params_locale || extract_cookies_locale || locate_from_header || I18n.default_locale
      cookies.permanent[:my_locale] = I18n.locale
    end
  end

  private

  def locate_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end

  def extract_params_locale
    params_locale = params[:lang]
    # I18n.available_locales.include?(params_locale.to_sym) ? params_locale : nil
    I18n.available_locales.map(&:to_s).include?(params_locale) ? params_locale : nil
  end

  def extract_cookies_locale
    cookies_locale = cookies[:my_locale]
    I18n.available_locales.include?(cookies_locale&.to_sym) ? cookies_locale : nil
  end

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :username, :email, :about, :birthday, :avatar, :language, :status]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  def update_user_online
    current_user.try :touch
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
