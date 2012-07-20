module Api
  module V1
    class PasswordsController < ApiController
      doorkeeper_for :all

      def update
        user = User.find(params[:user_id])

        if user.id == current_resource_owner.id
          if user.update_with_password(
            current_password: params[:current_password],
            password: params[:password],
            password_confirmation: params[:password_confirmation])

            sign_in user, bypass: true
            return head :ok
          else
            return head :unprocessable_entity
          end
        end

        if current_resource_owner.admin_of?(application)
          if user.update_attributes(password: params[:password],
                                    password_confirmation: params[:password_confirmation])
            head :ok
          else
            head :unprocessable_entity
          end
        else
          head :unauthorized
        end

      end
    end
  end
end
