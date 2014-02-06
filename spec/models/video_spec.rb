require 'spec_helper'

describe Video do
  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews).order("created_at DESC")}

  describe "search_by_title" do
    it "returns empty array if no videos found" do
      Video.search_by_title("Wizard").should == []
    end
    it "returns array with one element if one video found" do
      video1 = Video.create(title: "The Wizard of Oz", description: "great video")
      video2 = Video.create(title: "Citizen Kane", description: "mediocre video")
      Video.search_by_title("The Wizard of Oz").should == [video1]
    end

    it "returns array of one video for a partial match" do
      video1 = Video.create(title: "The Wizard of Oz", description: "great video")
      video2 = Video.create(title: "Citizen Kane", description: "mediocre video")
      Video.search_by_title("Wizard").should == [video1]
    end

    it "returns array with multiple elements if more than one video found ordered by created_at" do
      video1 = Video.create(title: "The Wizard of Oz", description: "great video", created_at: 1.day.ago)
      video2 = Video.create(title: "The Wizards of Waverly Place", description: "horrible video")
      Video.search_by_title("Wiz").should == [video2, video1]
    end

    it "returns an empty array for a search with an empty string" do
      video1 = Video.create(title: "The Wizard of Oz", description: "great video", created_at: 1.day.ago)
      video2 = Video.create(title: "The Wizards of Waverly Place", description: "horrible video")
      Video.search_by_title("").should == []
    end
  end

  describe "#average rating" do
    it "should return 0 if no ratings" do
      alice = Fabricate(:video)
      expect(alice.average_rating).to eq 0.0
    end
    it "should return the average if reviews exist" do
      alice = Fabricate(:video)
      Fabricate(:review, rating: 5, video: alice, user: Fabricate(:user))
      Fabricate(:review, rating: 2, video: alice, user: Fabricate(:user))
      expect(alice.average_rating).to eq 3.5
    end
  end

  describe "#on_queue?" do
    it "returns true when the user has queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user: user, video: video)
      video.on_queue?(user).should eq true
    end
    it "returns false when the user hasn't queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      video.on_queue?(user).should eq false
    end
  end

  describe "#reviewed?" do
    it "returns true when the user has reviewed the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:review, user: user, video: video)
      video.reviewed?(user).should eq true
    end
    it "returns false when the user hasn't reviewed the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      video.reviewed?(user).should eq false
    end
  end
end