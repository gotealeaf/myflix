require 'spec_helper'

describe Category do 

	it { should have_many(:videos) }

  describe "#recent_videos" do

    it "should return at most 6 videos per category" do
      @comedy = Category.create(name: "Comedy")
      @drama = Category.create(name: "Drama")
      @videos = Video.create([{title: "Family Guy", description: "A really twisted versino of the Simpsons", created_at: 3.day.ago, category: @comedy}, 
        {title: "True Detective", description: "A dark representation of crime and its investigation", created_at: 2.day.ago, category: @drama},
        {title: "Breaking Bad", description: "A high school chemistry teacher cooks meth to pay for his medical bills", created_at: 5.day.ago, category: @drama},
        {title: "Family Matters", description: "Steve Urkel...Yay!", created_at: 1.day.ago, category: @comedy}])
      @comedy.videos.each do |comedy|
        comedy
      expect(@comedy.videos).to eq([{title: "Family Guys"}, {title: "Family Matters"}])
      #expect(@drama.videos).to eq([@true_detective, @breaking_bad])
    end

  end
end