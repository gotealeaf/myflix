require 'spec_helper'

describe Category do 
  it { should have_many(:videos)}
  it { should validate_presence_of(:name) }

describe "#recent_videos" do
  
  it "returns empty array if no movies in category" do 
    comedy = Category.create(name: "Comedy")
    expect(comedy.recent_videos).to eq([])
  end

  it "returns the entire array if no. of movies in category is 6 or less sorted by created_date" do
    comedy = Category.create(name: "Comedy")
    f_guy0 = Video.create(title: "Family Guy0", description: "Follow the adventures", category: comedy, created_at: 3.day.ago)
    f_guy1 = Video.create(title: "Family Guy1", description: "Follow the adventures", category: comedy, created_at: 2.day.ago)
    f_guy2 = Video.create(title: "Family Guy2", description: "Follow the adventures", category: comedy, created_at: 1.day.ago)
    expect(comedy.recent_videos).to eq([f_guy2, f_guy1, f_guy0])
  end

  it "returns the recent 6 videos from in this categoy sorted by created_date" do
    comedy = Category.create(name: "Comedy")
    f_guy0 = Video.create(title: "Family Guy0", description: "Follow the adventures", category: comedy, created_at: 10.day.ago)
    f_guy1 = Video.create(title: "Family Guy1", description: "Follow the adventures", category: comedy, created_at: 9.day.ago)
    f_guy2 = Video.create(title: "Family Guy2", description: "Follow the adventures", category: comedy, created_at: 8.day.ago)
    f_guy3 = Video.create(title: "Family Guy3", description: "Follow the adventures", category: comedy, created_at: 7.day.ago)
    f_guy4 = Video.create(title: "Family Guy4", description: "Follow the adventures", category: comedy, created_at: 6.day.ago)
    f_guy5 = Video.create(title: "Family Guy5", description: "Follow the adventures", category: comedy, created_at: 5.day.ago)
    f_guy6 = Video.create(title: "Family Guy6", description: "Follow the adventures", category: comedy, created_at: 4.day.ago)
    f_guy7 = Video.create(title: "Family Guy7", description: "Follow the adventures", category: comedy, created_at: 3.day.ago)
    f_guy8 = Video.create(title: "Family Guy8", description: "Follow the adventures", category: comedy, created_at: 2.day.ago)
    expect(comedy.recent_videos.count).to eq(6)
  end
end

end

