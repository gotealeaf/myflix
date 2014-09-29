require 'spec_helper'

describe Invitation do
  it { should belong_to(:inviter) }
  it { should validate_presence_of(:recipient_email) }
  it { should validate_presence_of(:recipient_name) }
  it { should validate_presence_of(:message) }

  it_behaves_like "is_tokenable" do
    let(:record) {Fabricate(:invitation)}
  end

end
