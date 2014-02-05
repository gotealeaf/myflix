require 'spec_helper'

describe Relationship do
  it { should belong_to :follower }
  it { should belong_to :leader }
  it { should validate_presence_of :follower }
  it { should validate_presence_of :leader }
  it { should validate_uniqueness_of(:leader_id).scoped_to(:follower_id) }

  describe '::find_by_user_and_leader(following_user, leading_user)' do
    it 'returns nil if user is not following leader' do
      adam = Fabricate(:user)
      bryan = Fabricate(:user)
      expect(Relationship.find_by_user_and_leader(adam, bryan)).to be_nil
    end

    it 'returns relationship where user is following leader' do
      adam = Fabricate(:user)
      bryan = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: adam, leader: bryan)
      expect(Relationship.find_by_user_and_leader(adam, bryan)).to eq(relationship)
    end
  end
end
