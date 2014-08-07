require 'spec_helper'

describe Invitation do
  it { should validate_presence_of(:recipient_email) }
  it { should validate_presence_of(:recipient_name) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:inviter_id) }
  it { should belong_to(:inviter)}

  it_behaves_like "tokenify" do
    let(:object) { Fabricate(:invitation) }
  end
end
