require 'spec_helper'

describe Invitation do

  it { should validate_presence_of(:inviter_id  ) }
  it { should validate_presence_of(:friend_name ) }
  it { should validate_presence_of(:friend_email) }
  it { should validate_presence_of(:message     ) }

  describe "callbacks" do
    it "sets the invitation token before a record is created" do
      invite = Fabricate.build(:invitation, inviter_id: 1, token: nil)
      invite.save
      expect(Invitation.first.token).to_not be_nil
    end

    it_behaves_like "Tokenable" do
      let(:object) { Fabricate(:invitation, inviter_id: 1) }
    end
  end

  describe "friend_is_not_already_registered custom validator" do
    let(:joe) { Fabricate(:user) }
    it "allows creation if email is NOT already registered" do
      invite = Fabricate.build(:invitation, inviter_id: joe.id,
                                            friend_email: "sally@example.com" )
      expect(invite).to be_valid
    end
    it "prevents creation if email is already registered" do
      invite = Fabricate.build(:invitation, inviter_id: joe.id,
                                            friend_email: joe.email )
      expect(invite).to_not be_valid
    end
  end

  describe "clear_invitation_token" do
    it "clears the token to be nil an invalid" do
      invite = Fabricate(:invitation, inviter_id: 1, token: nil)
      invite.clear_invitation_token
      expect(invite.reload.token).to be_nil
    end
  end
end
