require 'spec_helper'

describe Category do 

	it { should have_many(:videos) }

  describe "#recent_videos" do
    it "should returns videos by order of their creation date" do
      @comedy = Category.create(name: "Comedy")
      @family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons", created_at: 3.day.ago, category: @comedy)
      @family_matters = Video.create(title: "Family Matters", description: "Steve Urkel...Yay!", created_at: 1.day.ago, category: @comedy)
      expect(@comedy.recent_videos).to eq([@family_matters, @family_guy])
    end

    it "should returns all videos if there are less than six in the category" do
      @comedy = Category.create(name: "Comedy")
      @family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons", created_at: 3.day.ago, category: @comedy)
      @family_matters = Video.create(title: "Family Matters", description: "Steve Urkel...Yay!", created_at: 1.day.ago, category: @comedy)
      expect(@comedy.recent_videos.count).to eq(2)
    end
    it "should returns only 6 videos if there are more than 6 videos in the category" do
      @comedy = Category.create(name: "Comedy")
      @family_guy = Video.create(title: "Family Guy", description: "A really twisted versino of the Simpsons", created_at: 3.day.ago, category: @comedy)
      @family_matters = Video.create(title: "Family Matters", description: "Steve Urkel...Yay!", created_at: 1.day.ago, category: @comedy)
      @always_sunny = Video.create(title: "Always Sunny", description: "O Philidelphia", created_at: 2.day.ago, category: @comedy)
      @the_office = Video.create(title: "The Office", description: "Those brits sure are funny", created_at: 5.day.ago, category: @comedy)
      @seinfeld = Video.create(title: "Seinfeld", description: "New York, New York", created_at: 7.day.ago, category: @comedy)
      @king_of_hill = Video.create(title: "King of the Hill", description: "Texas is the best.", created_at: 6.day.ago, category: @comedy)
      @simpsons = Video.create(title: "This simpsons", description: "Home is an OG", created_at: 3.day.ago, category: @comedy)
      @beavis_butthead = Video.create(title: "Beavis and Butthead", description: "too much mtv", created_at: 10.day.ago, category: @comedy)
      expect(@comedy.recent_videos.count).to eq(6)
    end
    it "should return the most recent 6 videos"
    it "should return an empty array if the category does not have any videos"
  end
end