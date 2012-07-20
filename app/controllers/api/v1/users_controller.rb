module Api
  module V1
    class UsersController < ApiController
      doorkeeper_for :all

      respond_to :json

      def index
        if current_resource_owner.admin_of?(application)
          users = User.of_app(application)
          respond_with users: users
        else
          head :unauthorized
        end
      end

      private

      def application
        @application ||= Doorkeeper::Application.find(params[:application_id])
      end
    end
  end
end
