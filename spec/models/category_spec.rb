require 'spec_helper'

describe Category do
  it { should have_many(:videos)}

  describe "#recent_videos" do
    it "should display the most recent 6 videos" do
      comedy = Category.create(name: "comedy")
      video1 = Video.create(title: "monk", description: "a television show", category: comedy)
      video2 = Video.create(title: "futurama", description: "an adult cartoon", category: comedy)
      video3 = Video.create(title: "family guy", description: "a funny show", category: comedy)
      video4 = Video.create(title: "elmo", description: "childrens show", category: comedy,  created_at: 1.day.ago)
      video5 = Video.create(title: "fight club", description: "a film starring brad pitt", category: comedy)
      video6 = Video.create(title: "brave heart", description: "a long good movie", category: comedy)
      video7 = Video.create(title: "fast and furious", description: "a car movie", category: comedy)
      expect(comedy.recent_videos).to eq([video7, video6, video5, video3, video2, video1])
    end

    it "should display all of the videos if less than 6" do
      comedy = Category.create(name: "comedy")
      video = 3.times { Video.create(title: "foo", description: "bar", category: comedy)}
      expect(comedy.recent_videos.count).to eq(3)
    end

    it "returns an empty array if category has no videos" do
      comedy = Category.create(name: "comedy")
      expect(comedy.recent_videos).to eq([])
    end
  end

end