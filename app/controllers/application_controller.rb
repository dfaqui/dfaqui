class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if (resource.has_role? :admin) || (resource.has_role? :property, :any) ||
        (resource.has_role? :market, :any)

      request.env['omniauth.origin'] || stored_location_for(resource) || admin_path
    else
      favorites_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
