require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items).order(:position) }
end
