require 'spec_helper'

describe Invitation do
  it { should belong_to(:inviter).class_name("User") }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:message) }

  it "validates that user is not already signed up" do
    alice = Fabricate(:user)
    invitation = Fabricate.build(:invitation, email: alice.email)
    expect(invitation).not_to be_valid
  end
end