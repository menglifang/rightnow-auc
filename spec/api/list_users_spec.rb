require 'spec_helper'

describe 'API', 'Listing users of an application', type: :request do
  let(:twitter) { create(:application, name: 'Twitter') }
  let(:facebook) { create(:application, name: 'Facebook') }

  context 'by administrator of the app' do
    let(:admin) { create(:admin_of, email: 'admin@example.org', application: twitter) }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: admin.id) }

    before do
      create(:user_of, email: 'tower@example.org', application: twitter)
      create(:user_of, email: 'jasmine@example.org', application: facebook)
    end

    it 'returns the users of the app' do
      get "/api/applications/#{twitter.id}/users?access_token=#{token.token}"

      response.status.should == 200

      pattern = {
        users: [{
          email: 'tower@example.org'
        }.ignore_extra_keys!, {
          email: 'admin@example.org'
        }.ignore_extra_keys!]
      }

      response.body.should match_json_expression(pattern)
    end
  end

  context 'when the retriever is a user of the app' do
    let(:tower) { create(:user_of, application: twitter, email: 'tower@example.org') }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: tower.id) }

    it 'responds with 401' do
      get "/api/applications/#{twitter.id}/users?access_token=#{token.token}"

      response.status.should == 401
    end
  end

  context 'when the retriever is not a user of the app' do
    let(:jasmine) { create(:user_of, application: twitter, email: 'jasmine@example.org') }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: jasmine.id) }

    it 'responds with 401' do
      get "/api/applications/#{twitter.id}/users?access_token=#{token.token}"

      response.status.should == 401
    end
  end
end
