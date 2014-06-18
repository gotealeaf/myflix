require 'rails_helper'

describe User do
  it { should validate_presence_of (:name) }
  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }
  it { should validate_uniqueness_of (:email) }
  it { should have_secure_password }

  it 'has a password that is at least 3 characters long' do
    user = User.create(name: "Test User", password: "12", email: "test@email.com")
    expect(User.count).to eq(0)
  end 
end