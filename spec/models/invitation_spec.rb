require 'spec_helper'

describe Invitation do
  it { should validate_presence_of(:inviter) }
  it { should validate_presence_of(:invitee_email) }
  it { should validate_presence_of(:invitee_name) }
  it { should validate_presence_of(:message) }
  it { should belong_to(:inviter).class_name(:User) }

  it "should validate that the email has not been registered" do
    jane = Fabricate(:user)
    sam = Fabricate(:user, email: 'sam@example.com')
    invitation = Invitation.create(inviter: jane, invitee_email: 'sam@example.com', invitee_name: 'Sam', message: 'Hi')
    expect(invitation).to have(1).error_on(:invitee_email)
  end
end