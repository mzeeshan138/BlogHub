class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_authentication, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def require_authentication
    return if public_page?

    authenticate_user!
  end

  def public_page?
    controller_name == "posts" && %w[index show].include?(action_name)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
