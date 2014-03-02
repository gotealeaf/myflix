require 'spec_helper'

describe Category do
  it { should have_many(:videos)}
  describe "#recent_videos" do
    it "returns the videos in the reverse order by created at" do
      actions = Category.create(name: "actions")
      kungfu = Video.create(title: "Kung Fu", description: "A panda name pao", category: actions, created_at: 1.day.ago)
      kungfu_panda = Video.create(title: "Kung Fu Panda", description: "A panda name pao", category: actions)
      expect(actions.recent_videos).to eq([kungfu_panda, kungfu])
    end
    it "returns all the videos if there are less than 6 videos" do
      actions = Category.create(name: "actions")
      kungfu = Video.create(title: "Kung Fu", description: "A panda name pao", category: actions, created_at: 1.day.ago)
      kungfu = Video.create(title: "Kung Fu", description: "A panda name pao", category: actions, created_at: 1.day.ago)
      expect(actions.recent_videos.count).to eq(2)
    end
    it "returns 6 videos if there are more than 6 videos" do
      actions = Category.create(name: "actions")
      7.times {Video.create(title: "Kung Fu", description: "A panda name pao", category: actions, created_at: 1.day.ago)}
      expect(actions.recent_videos.count).to eq(6)
    end
    it "returns the most recent 6 videos" do
      actions = Category.create(name: "actions")
      6.times {Video.create(title: "Kung Fu", description: "A panda name pao", category: actions, created_at: 1.day.ago)}
      last_video = Video.create(title: "7th video", description: "7 videos", category: actions, created_at: 2.day.ago)
      expect(actions.recent_videos).not_to include(last_video)
    end
    it "returns an empty array if the Category does not have any video" do
      actions = Category.create(name: "actions")
      expect(actions.recent_videos).to eq([])

    end
  end
end
