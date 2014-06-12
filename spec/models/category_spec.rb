require 'rails_helper.rb'

# shoulda gem syntax
describe Category do
  it { should have_many(:videos)}
  it { should validate_presence_of(:name)}

  describe "#recent_videos" do
    it "return the videos in reverse chronological order by created_at" do
      mob = Category.create(name: "Mob")
      good_fellas = Video.create(title: "Good Fellas", description: "classic", category: mob, created_at: 1.day.ago)
      godfather = Video.create(title: "The Godfather", description: "another classic", category: mob)
      expect(mob.recent_videos).to eq([godfather, good_fellas])
    end
    it "returns all videos if total less than six" do
      mob = Category.create(name: "Mob")
      good_fellas = Video.create(title: "Good Fellas", description: "classic", category: mob, created_at: 1.day.ago)
      godfather = Video.create(title: "The Godfather", description: "another classic", category: mob)
      expect(mob.recent_videos.count).to eq(2)
    end
    it "returns six videos if total greater than six" do
      mob = Category.create(name: "Mob")
      7.times {Video.create(title: "Mob Movie", description: "mob", category: mob)}
      expect(mob.recent_videos.count).to eq(6)
    end
    it "returns most recent six videos" do
      mob = Category.create(name: "Mob")
      6.times {Video.create(title: "Mob Movie", description: "mob", category: mob)}
      old_video = Video.create(title: "Old", description: "old", category: mob, created_at: 2.days.ago)
      expect(mob.recent_videos).not_to include(old_video)
    end
    it "returns empty aray if the category has no videos" do
      mob = Category.create(name: "Mob")
      expect(mob.recent_videos).to eq([])
    end
  end
end
 
