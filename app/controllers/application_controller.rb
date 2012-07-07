class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authenticate_admin!
    if block = Doorkeeper.configuration.authenticate_admin
      instance_eval &block
    end
  end
end
