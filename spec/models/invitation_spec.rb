require 'spec_helper'

describe Invitation do
  it { should validate_presence_of(:recipient_name) }
  it { should validate_presence_of(:recipient_email) }

  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:invitation) }
  end
end