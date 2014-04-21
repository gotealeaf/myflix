require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe User do
  it { should have_secure_password}
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  describe "number_of_queue_items" do
    it 'returns the correct number of queue items' do
      adam = Fabricate(:user)
      Fabricate(:queue_item, user: adam)
      Fabricate(:queue_item, user: adam)
      expect(adam.number_of_queue_items).to eq(2)
    end

    it 'returns the number of the users reviews' do
      adam = Fabricate(:user)
      Fabricate(:review, user: adam)
      Fabricate(:review, user: adam)
      expect(adam.number_of_reviews).to eq(2)
    end
  end

  describe 'generate random token for reset password' do
    it 'generates a random token' do
      user = Fabricate(:user)
      user.reset_token = user.generate_token(user.reset_token)
      user.save
      expect(User.first).to be_present
    end
  end

  describe 'user can have many followers' do
    it 'allows user to have many friends' do
      user = Fabricate(:user)
      follower = Fabricate(:user)
      relationship = Fabricate(:followship, user_id: user.id, follower_id: follower.id)
      expect(Followship.first).to eq(relationship)
      expect(User.first.followers).to eq([follower])
    end
  end
end
