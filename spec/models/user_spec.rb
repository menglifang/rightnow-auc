require 'spec_helper'

describe User do
  describe '.of_application' do
    let(:twitter) { create(:application, name: 'Twitter') }
    let(:facebook) { create(:application, name: 'Facebook') }

    before do
      @tower = create(:user_of, application: twitter, email: 'tower@example.org')
      @jasmine = create(:user_of, application: facebook, email: 'jasmine@example.org')
    end

    subject { User.of_application(twitter) }

    its(:count) { should == 1 }

    it 'includes tower' do
      subject.should be_include @tower
    end

    it 'does not include jasmine' do
      subject.should_not be_include @jasmine
    end
  end
end
