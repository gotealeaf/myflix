require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  
  it "shows all the videos if the result is less than 6 videos in reverse order" do
     category = Category.create(name: 'TV Comedies')
     video1 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video2 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video3 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video4 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video5 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     expect(category.videos.recent).to eq([video5, video4, video3, video2, video1])
   end

   it "shows only six videos if the result is more than six videos in reverse order" do
     category = Category.create(name: 'TV Comedies')
     video1 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video2 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video3 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video4 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video5 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video6 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     video7 = Video.create(name: "Monk", description: "This is monk video description", category: category)
     expect(category.videos.recent).to eq([video7, video6, video5, video4, video3, video2])
   end
end