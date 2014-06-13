require 'rails_helper'

describe Category do

  it { should have_many(:videos) }

  describe "recent_videos" do
    it "should turn an empty array if there are no videos in the category" do
      science_fiction = Category.create(name: "Science Fiction")
      action = Category.create(name: "Action")
      star_wars = Video.create(title: "Star Wars", description: "May the Force be with you", category: science_fiction)
      expect(action.recent_videos).to eq([])
    end
    
    it "should return 6 objects if there are 6 or more videos in the category" do
      science_fiction = Category.create(name:"Science Fiction")
      action = Category.create(name: "Action")
      7.times {Video.create(title:"Movie Title", description: "Movie Description", category: science_fiction)}
      expect(science_fiction.recent_videos.count).to eq(6)
    end
    
    it "should return only videos in this category" do
      science_fiction = Category.create(name: "Science Fiction")
      action = Category.create(name: "Action")
      star_wars = Video.create(title: "Star Wars", description: "May the Force be with you", category: science_fiction)
      die_hard = Video.create(title: "Die Hard", description: "Only gets more difficult", category: action)
      expect(action.recent_videos).to eq([die_hard])
    end
    
    it "should order videos from newest to oldest" do 
      science_fiction = Category.create(name: "Science Fiction")
      star_wars_two = Video.create(title: "Star Wars", description: "May the Force be with you", category: science_fiction, created_at: 1.day.ago)
      star_wars = Video.create(title: "Empire Strikes Back", description: "Its cold on Hoth", category: science_fiction)
      expect(science_fiction.recent_videos).to eq([star_wars,star_wars_two])
    end
    
    it "should return the 6 most recent videos" do
      science_fiction = Category.create(name: "Science Fiction")
      6.times {Video.create(title:"Movie Title", description: "Movie Description", category: science_fiction)}
      star_wars = Video.create(title: "Star Wars", description: "May the Force be with you", category: science_fiction, created_at: 1.day.ago)
      expect(science_fiction.recent_videos).not_to include(star_wars)
    end
    
  end
  
end