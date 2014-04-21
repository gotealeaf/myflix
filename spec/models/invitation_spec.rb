require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe Invitation do

  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:status) }

  describe 'random token' do
    it 'generates a random token' do
      invite = Fabricate(:invitation)
      invite.generate_token(invite.invite_token)
      expect(Invitation.first.invite_token).to be_present
    end
  end
end
