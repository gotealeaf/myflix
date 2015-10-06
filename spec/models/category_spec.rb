require "spec_helper"

describe Category do
  it { should have_many(:videos)}

  describe "recent_videos" do
    it "return the videos in the reverse chronical order by created at" do
      epic = Category.create(name: "epic")
      first_video = Video.create(title: "Game of thones", description: "epic movie", category: epic, created_at: 1.day.ago)
      second_video = Video.create(title: "300", description: "epic movie", category: epic)
      expect(epic.recent_videos).to eq([second_video, first_video])
    end

    it "returns all the videos if there are less than 6 videos" do
      epic = Category.create(name: "epic")
      first_video = Video.create(title: "Game of thones", description: "epic movie", category: epic, created_at: 1.day.ago)
      second_video = Video.create(title: "300", description: "epic movie", category: epic)
      expect(epic.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do
      epic = Category.create(name: "epic")
      7.times {Video.create(title: "Game of thones", description: "epic movie", category: epic, created_at: 1.day.ago)}
      expect(epic.recent_videos.count).to eq(6)     
    end

    it "return the most recent 6 videos" do
      epic = Category.create(name: "epic")
      6.times {Video.create(title: "Game of thones", description: "epic movie", category: epic)}
      spartacus = Video.create(title: "Spartacus", description: "exicting movie", created_at: 1.day.ago)
      expect(epic.recent_videos).not_to include(spartacus)      
    end

    it "returns an empty array if the category does not have any videos" do
      epic = Category.create(name: "epic")
      expect(epic.recent_videos).to eq([])
    end

  end




  
end