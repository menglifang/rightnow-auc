require 'spec_helper'

describe 'API', 'Reset the password of users of an application', type: :request do
  let(:twitter) { create(:application, name: 'Twitter') }

  context 'when the operator is an administrator of the app' do
    let(:admin) { create(:admin_of, email: 'admin@example.org', application: twitter) }
    let(:tower) { create(:user_of, application: twitter, email: 'tower@example.org') }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: admin.id) }

    it 'resets the password' do
      put "/api/applications/#{twitter.id}/users/#{tower.id}/password?access_token=#{token.token}",
          'password' => '12345678',
          'password_confirmation' => '12345678'

      response.status.should == 200
    end

    context 'and trying to reset the password of self' do
      context 'with the current password' do
        it 'resets the password' do
          put "/api/applications/#{twitter.id}/users/#{admin.id}/password?access_token=#{token.token}",
              'current_password' => '123456',
              'password' => '12345678',
              'password_confirmation' => '12345678'

          response.status.should == 200
        end
      end

      context 'without passing the current password' do
        it 'responds with 422' do
          put "/api/applications/#{twitter.id}/users/#{admin.id}/password?access_token=#{token.token}",
              'password' => '12345678',
              'password_confirmation' => '12345678'

          response.status.should == 422
        end
      end
    end
  end

  context 'when the operator is not an administrator of the app' do
    let(:tower) { create(:user_of, application: twitter, email: 'tower@example.org') }
    let(:jasmine) { create(:user_of, application: twitter, email: 'jasmine@example.org') }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: tower.id) }

    context 'and trying to reset the password of others' do
      it 'responds with 401' do
        put "/api/applications/#{twitter.id}/users/#{jasmine.id}/password?access_token=#{token.token}",
            'password' => '12345678',
            'password_confirmation' => '12345678'

        response.status.should == 401
      end
    end

    context 'and trying to reset the password of self' do
      context 'with the current password' do
        it 'resets the password' do
          put "/api/applications/#{twitter.id}/users/#{tower.id}/password?access_token=#{token.token}",
              'current_password' => '123456',
              'password' => '12345678',
              'password_confirmation' => '12345678'

          response.status.should == 200
        end
      end

      context 'without passing the current password' do
        it 'responds with 422' do
          put "/api/applications/#{twitter.id}/users/#{tower.id}/password?access_token=#{token.token}",
              'password' => '12345678',
              'password_confirmation' => '12345678'

          response.status.should == 422
        end
      end
    end
  end
end
