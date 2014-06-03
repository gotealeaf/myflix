require 'spec_helper'

describe Category do
  it "should save a new category" do
    category = Category.create!(name: 'Action')
    expect(category.name).to eq 'Action'
  end

  it { should have_many(:videos) } 
  it { should validate_presence_of(:name) } 

  describe "#recent_videos" do
    it "should return the 6 most recent videos for each category" do
      category = Category.create!(name: 'Action')
  
      video1 = Video.create!(title: 'Futurama1', description: 'Futurama1')
      category.videos << video1
      video2 = Video.create!(title: 'Futurama2', description: 'Futurama2')
      category.videos << video2
      video3 = Video.create!(title: 'Futurama3', description: 'Futurama3')
      category.videos << video3
      video4 = Video.create!(title: 'Futurama4', description: 'Futurama4')
      category.videos << video4
      video5 = Video.create!(title: 'Futurama5', description: 'Futurama5')
      category.videos << video5
      video6 = Video.create!(title: 'Futurama6', description: 'Futurama6')
      category.videos << video6
      video7 = Video.create!(title: 'Futurama7', description: 'Futurama7')
      category.videos << video7
  
      expect(category.recent_videos.size).to eq 6
      expect(category.recent_videos).to eq [video7, video6, video5, video4, video3, video2]
    end

    it "should return all videos if less than 6 in category" do
      category = Category.create!(name: 'Action')
  
      video1 = Video.create!(title: 'Futurama1', description: 'Futurama1')
      category.videos << video1
      video2 = Video.create!(title: 'Futurama2', description: 'Futurama2')
      category.videos << video2
  
      expect(category.recent_videos.size).to eq 2
      expect(category.recent_videos).to eq [video2, video1]
    end

    it "should return an empty array if no videos for this category" do
      category = Category.create!(name: 'Action')
  
      video = Video.create!(title: 'Futurama1', description: 'Futurama1')
  
      expect(category.recent_videos).to eq []
    end
  end

end
