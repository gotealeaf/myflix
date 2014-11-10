require 'spec_helper'

describe Invitation do
  
  it { should validate_presence_of(:friend_email) }
  it { should belong_to(:user) }
  
  it_behaves_like "tokenable" do
    let(:object) { Fabricate(:invitation) }
  end
  
end