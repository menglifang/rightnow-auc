module Api::V1
  class ApiController < ::ApplicationController
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    protected
    def application
      @application ||= Doorkeeper::Application.find(params[:application_id])
    end
  end
end
