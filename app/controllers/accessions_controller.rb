class AccessionsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    user = User.find(params[:user_id])
    @accessible_applications = user.applications
    @inaccessible_applications = Doorkeeper::Application.all - user.applications
  end
end
