require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}

  describe "search_by_title" do
    it "returns an empty array if there are no matches" do
      futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("hello")).to eq([])
    end
    it "returns an array of one video for an exact match" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("futurama")).to eq([futurama])
    end
    it "returns an array of one video for a partial match" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("urama")).to eq([futurama])
    end
    it "returns an array of all matches ordered by created_at" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("futur")).to eq([back_to_future, futurama])
    end
    it "returns an array for a search with an empty string" do
    	futurama = Video.create(title: "Futurama", description: "A show about Space travel")
      back_to_future = Video.create(title: "Back to Future", description: "Time Travel!")
      expect(Video.search_by_title("")).to eq([])
    end
  end

  describe "search_by_title_categorized" do
    it "categorizes the search results" do
      comedies = Category.create(name: "Comedies")
      dramas = Category.create(name: "Dramas")
      westerns = Category.create(name: "Westerns")
      thrillers = Category.create(name: "Thriller")

      friends = comedies.videos.create(title: "Friends", description: "A bunch of friends")
      good_friends = comedies.videos.create(title: "Good Friends", description: "They go to bars")
      friends_and_foe = dramas.videos.create(title: "Dramatic Friends", description: "Always getting in fights")
      the_friends_saloon = westerns.videos.create(title: "Western Friends", description: "Shooting each other")
      cowboy_friends = westerns.videos.create(title: "Cowboy Friends", description: "Riding Horses")
      zombies = thrillers.videos.create(title: "Zombies", description: "Braaaains")

      results = Video.search_by_title_categorized("Friends")
      expect(results).to eq({
          comedies => Set.new([friends, good_friends]),
          dramas => Set.new([friends_and_foe]),
          westerns => Set.new([the_friends_saloon, cowboy_friends])
        })
    end
  end
end