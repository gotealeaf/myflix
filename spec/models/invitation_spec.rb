require 'spec_helper'

describe Invitation do
  it {should belong_to(:inviter)}
  it {should validate_presence_of(:guest_email)}
  it {should validate_presence_of(:guest_name)}
  it {should validate_presence_of(:message)}

  it "generates a random token when the invitation is created" do
    invitation = Fabricate(:invitation)
    expect(invitation.token).to be_present
  end
end