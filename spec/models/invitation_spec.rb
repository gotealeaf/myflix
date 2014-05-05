require 'spec_helper'

describe Invitation do
  it { should belong_to(:inviter).class_name("User") }
  it { should validate_presence_of(:recipient_email) }
  it { should validate_presence_of(:recipient_name) }
  it { should validate_presence_of(:message) }

  it_behaves_like "tokenable" do 
    let(:object) { Fabricate(:invitation) }
  end

  it "validates that user is not already signed up" do
    alice = Fabricate(:user)
    invitation = Fabricate.build(:invitation, recipient_email: alice.email)
    invitation.save
    expect(invitation.errors.full_messages).to include("Recipient email is already signed up")
  end
end