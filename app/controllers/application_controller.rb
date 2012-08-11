class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authenticate_admin!
    if block = Doorkeeper.configuration.authenticate_admin
      instance_eval &block
    end
  end

  def after_sign_out_path_for(resource)
    params[:redirect_to] || super(resource)
  end
end
