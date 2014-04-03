require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user ) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:position  ) }
  it { should validate_presence_of(:user_id   ) }
  it { should validate_presence_of(:video_id  ) }
  it { should validate_uniqueness_of(:position) }
  it { should validate_uniqueness_of(:user_id ).scoped_to(:video_id) }
  it { should validate_uniqueness_of(:position).scoped_to(:user_id ) }

  let(:category) { Fabricate(:category) }
  let(:user)     { Fabricate(:user) }
  let(:video)    { Fabricate(:video) }


  describe "queue_item.video_title method" do
    it "returns the title for associated video" do
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.video_title).to eq(video.title)
    end
  end

  describe "video_categories method" do
    it "returns the categories for associated video" do
      video      = Fabricate(:video, categories: [category])
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.video_categories).to match_array(video.categories)
    end
    it "returns the categories in alphabetical order by name"
  end

  describe "video_category_names method" do
    it "returns the category names array for associated video" do
      category1  = Fabricate(:category)
      category2  = Fabricate(:category)
      video      = Fabricate(:video, categories: [category1, category2])
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.video_category_names).to match_array([category1, category2])
    end
    it "returns nil if there is no category associated with the video" do
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.video_category_names).to be_nil
    end
    it "returns the category names in alphabetical order"
  end

  describe "user_rating method" do
    it "returns the rating for associated user's review (when present)" do
      review     = Fabricate(:review, rating: 4, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.user_rating).to eq(review.rating)
    end
    it "returns nil if there is no review by the user" do
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.user_rating).to be_nil
    end
  end

  describe "arrange_queue_position! method" do
    it "re-orders queue item position in ascending relative order of relative positions given"
      #expect(QueueItem.all.each.map(&:position)).to eq([1,2])
    it "returns true if successful"
  end
end
