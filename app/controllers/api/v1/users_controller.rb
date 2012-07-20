module Api
  module V1
    class UsersController < ApiController
      doorkeeper_for :all
      before_filter :check_admin_of_app

      respond_to :json

      def index
        users = User.of_app(application)

        render json: { users: users }, status: :ok
      end

      def create
        user = User.new(params[:user])
        if user.save
          render json: user, status: :created
        else
          head :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])

        if user.id == current_resource_owner.id
          head :unauthorized
        else
          user.destroy
          head :ok
        end
      end

      private

      def check_admin_of_app
        unless current_resource_owner.admin_of?(application)
          head :unauthorized
        end
      end
    end
  end
end
