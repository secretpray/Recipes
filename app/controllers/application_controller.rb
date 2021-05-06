class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_theme
  
  helper_method :favorite_text
  # protect_from_forgery

  def set_theme
    if params[:theme].present?
      theme = params[:theme].to_sym
      # session[:theme] = theme
      cookies[:theme] = theme
      redirect_to(request.referrer || root_path)
    end
  end

  def favorite_text
    return @favorite_exists ?  "&#x2764;&#xfe0f;".html_safe : "&#x2661;".html_safe
  end

  # def after_sign_up_path_for(resource)
  #   recipes_path
  # end
  
  # def after_sign_in_path_for(resource)
  #   recipes_path
  # end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
