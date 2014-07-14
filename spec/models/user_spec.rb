require 'rails_helper'

describe User do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
  it { should have_secure_password }
  it { should have_many(:reviews) }
  it { should have_many(:queue_items) }

  describe "auth_token" do
    it "should create a new auth_token when a user is created" do
      user = User.create(full_name:'John Doe',email:'john-doe@example.com', password:'p', password_confirmation: 'p')
      expect(user.auth_token.nil?).to eq(false)
    end
  end
  
  describe '#queued_video?(video)' do
    it ' should return true if already in user queue' do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      expect(user.queued_video?(video)).to eq(true)
    end
    
    it ' should return false  if not in user queue' do
      user = Fabricate(:user)
      video = Fabricate(:video)
      expect(user.queued_video?(video)).to eq(false)
    end
  end


end
