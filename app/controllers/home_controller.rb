class HomeController < ApplicationController
  before_filter :authenticate_user!

  def show
    if current_user.admin?
      render
    else
      redirect_to accessible_applications_url
    end
  end
end
