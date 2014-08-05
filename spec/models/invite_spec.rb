require "spec_helper"

describe Invite do
  it { should belong_to(:user) }

  it_behaves_like "generate_token" do
    let(:instance) { Fabricate(:invite) }
  end
end