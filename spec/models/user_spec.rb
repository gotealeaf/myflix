require 'rails_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password }
  it { should have_many(:reviews) }

  describe "auth_token" do
    it "should create a new auth_token when a user is created" do
      user = User.create(full_name:'John Doe',email:'john-doe@example.com', password:'p', password_confirmation: 'p')
      expect(user.auth_token.nil?).to eq(false)
    end
  end


end
