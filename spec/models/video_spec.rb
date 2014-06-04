require 'rails_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  
  describe 'search_by_title' do 
    it "returns empty array if no match" do 
      video1 = Video.create(title: "video1", description: "some description")
      video2 = Video.create(title: "another video2", description: "another description")
      expect(Video.search_by_title("title")).to eq([])
    end

    it "returns one-video array for one exact match" do 
      video1 = Video.create(title: "video1", description: "some description")
      video2 = Video.create(title: "another video2", description: "another description")
      expect(Video.search_by_title("video1")).to eq([video1])
    end

    it "returns one-video array for one partial match" do 
      video1 = Video.create(title: "video1", description: "some description")
      video2 = Video.create(title: "another video2!!!", description: "another description")
      expect(Video.search_by_title("vIDEo2")).to eq([video2])
    end

    it "returns an array of all matches ordered by created_at" do 
      video1 = Video.create(title: "video1", description: "some description", created_at: 3.minutes.ago)
      video2 = Video.create(title: "another video2!!!", description: "another description", created_at: 2.minutes.ago)
      expect(Video.search_by_title("ViDeO")).to eq([video2, video1]) 
    end

    it "returns an empty array for a search with an empty string" do 
      video1 = Video.create(title: "video1", description: "some description", created_at: 3.minutes.ago)
      video2 = Video.create(title: "another video2!!!", description: "another description", created_at: 2.minutes.ago)
      expect(Video.search_by_title("")).to eq([])  
    end
  end

end