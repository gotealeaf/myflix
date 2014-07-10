require "spec_helper"

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_uniqueness_of(:video_id) } 
  it { should validate_numericality_of(:position).only_integer }

  describe "#video_title" do
    it "returns the title of the associated video" do
      family_guy = Fabricate(:video, title: "Family Guy")
      queue_item = Fabricate(:queue_item, video: family_guy)
      expect(queue_item.video_title).to eq("Family Guy")
    end
  end

  describe "#rating" do
    let (:family_guy) { Fabricate(:video) }

    it "returns the rating of the associated review when rating present" do
      sarah = Fabricate(:user)
      review = Fabricate(:review, rating: 4, video_id: family_guy.id, user_id: sarah.id)
      queue_item = Fabricate(:queue_item, video: family_guy, user: sarah)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when there is no rating" do
      queue_item = Fabricate(:queue_item, video: family_guy)
      expect(queue_item.rating).to be(nil)
    end
  end

  describe "#rating=" do
    let(:sarah) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }
    let(:review) { Fabricate(:review, rating: 5, video_id: video.id, user_id: sarah.id) }
    let(:queue_item) { Fabricate(:queue_item, video: video, user: sarah) }

    it "updates the rating of the existing review" do
      queue_item.rating = 3
      expect(Review.first.rating).to eq(3)
    end

    it "clears the rating of the existing review" do
      queue_item.rating = nil
      expect(Review.first.rating).to eq(nil)
    end

    it "creates a new review with a rating if no review exists" do
      video2 = Fabricate(:video)
      queue_item2 = Fabricate(:queue_item, video: video2, user: sarah)
      queue_item2.rating = 3
      expect(Review.last.rating).to eq(3)
    end
  end

  describe "#category_name" do
    it "returns the name of the category associated to the video" do
      comedy = Fabricate(:category, name: "Funny")
      family_guy = Fabricate(:video, category: comedy)
      queue_item = Fabricate(:queue_item, video: family_guy)
      expect(queue_item.category_name).to eq("Funny")
    end
  end

  describe "#category" do
    it "returns the category associated to the video" do
      comedy = Fabricate(:category)
      family_guy = Fabricate(:video, category: comedy)
      queue_item = Fabricate(:queue_item, video: family_guy)
      expect(queue_item.category).to eq(comedy)
    end
  end

end