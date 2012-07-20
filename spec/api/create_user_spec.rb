require 'spec_helper'

describe 'API', 'Creating a user of an application', type: :request do
  let(:twitter) { create(:application, name: 'Twitter') }

  context 'when the creator is an administrator of the app' do
    let(:admin) { create(:admin_of, email: 'admin@example.org', application: twitter) }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: admin.id) }

    it 'creates a user' do
      post "/api/applications/#{twitter.id}/users?access_token=#{token.token}", 
           "user[email]" => 'tower@example.org',
           "user[password]" => '123456',
           "user[password_confirmation]" => '123456'

      response.status.should == 201

      pattern = {
        email: 'tower@example.org'
      }.ignore_extra_keys!

      response.body.should match_json_expression(pattern)
    end
  end

  context 'when the creator is not an administrator of the app' do
    let(:tower) { create(:user_of, application: twitter, email: 'tower@example.org') }
    let(:token) { create(:access_token, application: twitter, resource_owner_id: tower.id) }

    it 'responds with 401' do
      post "/api/applications/#{twitter.id}/users?access_token=#{token.token}", 
           "user[email]" => 'jasmine@example.org',
           "user[password]" => '123456',
           "user[password_confirmation]" => '123456'

      response.status.should == 401
    end
  end
end
