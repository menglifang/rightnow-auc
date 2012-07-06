class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authenticate_admin!
    if block = Doorkeeper.configuration.authenticate_admin
      instance_eval &block
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.admin?
        users_url
      else
        accessible_applications_url
      end
  end
end
