require 'spec_helper'

describe Category do 

	it { should have_many(:videos) }

  describe "#recent_videos" do
    it "should returns videos by order of their creation date" do
      @videos = Video.create([{title: "Family Guy", description: "A really twisted versino of the Simpsons", created_at: 3.day.ago, category: @comedy},
                              {title: "True Detective", description: "A dark representation of crime and its investigation", created_at: 2.day.ago, category: @drama},
                              {title: "Breaking Bad", description: "A high school chemistry teacher cooks meth to pay for his medical bills", created_at: 5.day.ago, category: @drama},
                              {title: "Family Matters", description: "Steve Urkel...Yay!", created_at: 1.day.ago, category: @comedy}])
      
    end
    it "should returns all videos if there are less than six in the category"
    it "should returns only 6 videos if there are more than 6 videos in the category"
    it "should return the most recent 6 videos"
    it "should return an empty array if the category does not have any videos"
  end
end