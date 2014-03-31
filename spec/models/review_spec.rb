require 'spec_helper'

describe Review do
  it { should belong_to(:video) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:video) }
end