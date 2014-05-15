require 'spec_helper'

describe Category do
  it {should have_many(:videos)}
  
  
  describe "#recent_videos" do
    it "should return the videos sorted by created date most recent first" do
      comedy = Category.create(name: 'Comedy')
      video1 = Video.create(title: 'The Family Guy 1', description: 'A comedy about a family and their dog.', category: comedy, created_at: 7.day.ago)
      video2 = Video.create(title: 'The Family Guy 2', description: 'A comedy about a family and their dog.', category: comedy, created_at: 6.day.ago)
      video3 = Video.create(title: 'The Family Guy 3', description: 'A comedy about a family and their dog.', category: comedy, created_at: 5.day.ago)
      expect(comedy.recent_videos).to eq([video3, video2, video1])
    end
    
    it "should return all videos if there are less then six" do
      comedy = Category.create(name: 'Comedy')
      3.times do
        Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.', category: comedy)
      end
      expect(comedy.recent_videos.count).to eq(3)
    end 

    it "should return six videos if there are more then six" do
      comedy = Category.create(name: 'Comedy')
      8.times do
        Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.', category: comedy)
      end
      expect(comedy.recent_videos.count).to eq(6)
    end

    it "should return the six most recent videos" do
      comedy = Category.create(name: 'Comedy')
      6.times do
        Video.create(title: 'The Family Guy', description: 'A comedy about a family and their dog.', category: comedy)
      end
      video7 = Video.create(title: 'The Family Guy 1', description: 'A comedy about a family and their dog.', category: comedy, created_at: 7.day.ago)
      expect(comedy.recent_videos).not_to include(video7)
    end
    
    it "should return an empty array of there are no videos" do
      comedy = Category.create(name: 'Comedy')
      expect(comedy.recent_videos).to eq([])
    end
    
  end
  
end
  