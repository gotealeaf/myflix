require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:video) }
  #it { should validate_presence_of(:position) }

  it "validates uniqueness of position" do
    queue_item = Fabricate(:queue_item)
    expect(queue_item).to validate_uniqueness_of(:position).scoped_to(:user_id)
  end

  describe "#assign_position" do
    it "assigns a position" do
      expect(Fabricate(:queue_item).position).to eq(1)
    end

    it "assigns the next position if the user has several queue_items" do
      user = Fabricate(:user)
      Fabricate(:queue_item, user: user)
      expect(Fabricate(:queue_item, user: user).position).to eq(2)
    end
  end
end