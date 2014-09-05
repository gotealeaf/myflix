require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should have_many(:reviews) }
  it { should have_many(:queue_items) }
end
