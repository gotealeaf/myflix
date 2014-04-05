require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "recent_videos" do

    it "reurns an array of videos of a certain category" do
      cat1 = Category.create(name: "cat_recent_videos1")
      cat2 = Category.create(name: "cat_recent_videos2")

      video_one = Video.create(title: "Video 1", description: "Brasas brasas.", category: cat1)
      video_two = Video.create(title: "Video 2", description: "Brasas brasas.", category: cat1)
      video_three = Video.create(title: "Video 3", description: "Brasas brasas.", category: cat2)    
      video_four = Video.create(title: "Video 4", description: "Brasas brasas.", category: cat2) 
      
      expect(Category.recent_videos(cat1)).to include(video_one, video_two)  

    end

    it "return an array of videos of a certain category, order by crated at" do
      cat = Category.create(name: "cat_recent_videos")
      video_one = Video.create(title: "Video 1", description: "Brasas brasas.", category: cat, created_at: 3.day.ago)
      video_two = Video.create(title: "Video 2", description: "Brasas brasas.", category: cat, created_at: 2.day.ago)
      video_three = Video.create(title: "Video 3", description: "Brasas brasas.", category: cat, created_at: 1.day.ago)    
      video_four = Video.create(title: "Video 4", description: "Brasas brasas.", category: cat) 
      
      expect(Category.recent_videos(cat)).to eq([video_four, video_three, video_two, video_one])  
    end

    it "returns and array of six videos of a category when thay are more than six" do
      cat = Category.create(name: "cat_recent_videos")
      video_one = Video.create(title: "Video 1", description: "Brasas brasas.", category: cat, created_at: 7.day.ago)
      video_two = Video.create(title: "Video 2", description: "Brasas brasas.", category: cat, created_at: 6.day.ago)
      video_three = Video.create(title: "Video 3", description: "Brasas brasas.", category: cat, created_at: 5.day.ago)    
      video_four = Video.create(title: "Video 4", description: "Brasas brasas.", category: cat, created_at: 4.day.ago) 
      video_five = Video.create(title: "Video 5", description: "Brasas brasas.", category: cat, created_at: 3.day.ago)
      video_six = Video.create(title: "Video 6", description: "Brasas brasas.", category: cat, created_at: 2.day.ago)    
      video_seven = Video.create(title: "Video 7", description: "Brasas brasas.", category: cat, created_at: 1.day.ago) 
      video_eight = Video.create(title: "Video 8", description: "Brasas brasas.", category: cat) 
      
      expect(Category.recent_videos(cat).count).to eq(6) 
    end



  end

end