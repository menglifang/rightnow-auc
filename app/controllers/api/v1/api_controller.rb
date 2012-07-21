module Api::V1
  class ApiController < ::ApplicationController
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    protected
    def application
      @application ||= begin
                         id_or_key_name = params[:application_id]
                         Doorkeeper::Application.find_by_key_name(id_or_key_name) ||
                           Doorkeeper::Application.find_by_id(id_or_key_name)
                       end
    end
  end
end
