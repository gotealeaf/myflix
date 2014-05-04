require 'spec_helper'

describe Invitation do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:invitee_email) }
end