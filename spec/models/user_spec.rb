require 'spec_helper'

describe User do
  before(:each) do
    User.create(
      full_name: "Bob",
      email: "bob@example.com",
      password: "admin",
      password_confirmation: "admin"
    )
  end
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order("position ASC") }
end