class AccessibleApplicationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @applications = current_user.applications.page(params[:page])
  end
end
