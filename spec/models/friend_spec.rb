require 'spec_helper'

describe Friend do
  it { should belong_to(:user) }
  
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:user_id) }

  it_behaves_like "tokenable", :friend
end