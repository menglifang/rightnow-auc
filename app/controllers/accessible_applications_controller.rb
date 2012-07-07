class AccessibleApplicationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @applications = current_user.applications
  end
end
