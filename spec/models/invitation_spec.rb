require 'spec_helper'

describe Invitation do
  it { should validate_presence_of(:inviter) }
  it { should validate_presence_of(:invitee_email) }
  it { should belong_to(:inviter).class_name(:User).with_foreign_key(:user_id) }
end