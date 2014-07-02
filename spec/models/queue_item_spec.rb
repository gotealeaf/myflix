require "spec_helper"

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_uniqueness_of(:video_id) } 
  it { should validate_numericality_of(:position).only_integer }

  describe "#video_title" do
    it "returns the title of the associated video" do
      family_guy = Fabricate(:video, title: "Family Guy")
      queue_item = Fabricate(:queue_item, video: family_guy, position: 1)
      expect(queue_item.video_title).to eq("Family Guy")
    end
  end

  describe "#video_rating" do
    it "returns the rating of the associated review when rating present" do
      sarah = Fabricate(:user)
      family_guy = Fabricate(:video)
      review = Fabricate(:review, rating: 4, video_id: family_guy.id, user_id: sarah.id)
      queue_item = Fabricate(:queue_item, video: family_guy, user: sarah, position: 1)
      expect(queue_item.video_rating).to eq(4)
    end

    it "returns not rated string when there is no rating" do
      family_guy = Fabricate(:video, title: "Family Guy")
      queue_item = Fabricate(:queue_item, video: family_guy, position: 1)
      expect(queue_item.video_rating).to be_a(String)
    end
  end

  describe "#category_name" do
    it "returns the name of the category associated to the video" do
      comedy = Fabricate(:category, name: "Funny")
      family_guy = Fabricate(:video, category: comedy)
      queue_item = Fabricate(:queue_item, video: family_guy, position: 1)
      expect(queue_item.category_name).to eq("Funny")
    end
  end

  describe "#category" do
    it "returns the category associated to the video" do
      comedy = Fabricate(:category)
      family_guy = Fabricate(:video, category: comedy)
      queue_item = Fabricate(:queue_item, video: family_guy, position: 1)
      expect(queue_item.category).to eq(comedy)
    end
  end
end