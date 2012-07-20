require 'spec_helper'

describe 'API', 'Deleting a user of an application', type: :request do
  let(:twitter) { create(:application, name: 'Twitter') }

  context 'when the operator is an administrator of the app' do
    let(:admin) { create(:admin_of, email: 'admin@example.org', application: twitter) }
    let(:tower) { create(:user_of, application: twitter, email: 'tower@example.org') }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: admin.id) }

    it 'deletes the user' do
      delete "/api/applications/#{twitter.id}/users/#{tower.id}?access_token=#{token.token}"

      response.status.should == 200
    end

    context 'when trying to delete self' do
      it 'responds with 401' do
        delete "/api/applications/#{twitter.id}/users/#{admin.id}?access_token=#{token.token}"

        response.status.should == 401
      end
    end
  end

  context 'when the operator is not an administrator of the app' do
    let(:tower) { create(:user_of, application: twitter, email: 'tower@example.org') }
    let(:jasmine) { create(:user_of, application: twitter, email: 'jasmine@example.org') }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: tower.id) }

    it 'responds with 401' do
      delete "/api/applications/#{twitter.id}/users/#{jasmine.id}?access_token=#{token.token}"

      response.status.should == 401
    end
  end
end
