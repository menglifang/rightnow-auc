class AccessionsController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :load_user

  def index
    @accessions = @user.accessions
    @inaccessible_applications = Doorkeeper::Application.all - @user.applications
  end

  def create
    @user.accessions.create(application_id: params[:application_id])

    redirect_to user_accessions_url(@user)
  end

  def destroy
    accession = Accession.find(params[:id])
    accession.destroy

    redirect_to user_accessions_url(@user)
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end
end
