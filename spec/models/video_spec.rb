require 'spec_helper'

describe Video do

  it { should have_many(:categories) }
  it { should have_many(:categories).through(:video_categories)}
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

# describe Video do
# 	before do
# 	  @category = Category.create(name: "Humor")
# 	end


#   it "saves itself" do
#   	video = Video.new(title: "Game of Thrones", description: "Fantasy", large_cover_url: 'large_url.jpg', small_cover_url: 'small.jpg')
#   	video.save
#   	expect(Video.first).to eq(video)
#   end


#   it "has categories" do
#     video = Video.new(title: "The Mask", description: "Funny man Jim Carey", large_cover_url: "large_url.jpg", small_cover_url: "small_cover_url.png")
#  		VideoCategory.create(category: @category, video: video)
 		
#  		expect(video.categories.count).to eq(1)
#  		expect(video.categories[0]).to eq(@category)

#   end

#   it "requires title" do
#   	video = Video.new(description: "A great movie", large_cover_url: "large_url.jpg", small_cover_url:'small_cover_url.jpg')
#   	video.save
#   	expect(video.errors.any?).to eq(true)
#   	expect(Video.count).to eq(0)

#   end

#   it "requires description" do
#   	video = Video.new(title: "I Robot", large_cover_url: "large_url.jpg", small_cover_url:'small_cover_url.jpg')
#   	video.save
#   	expect(video.errors.any?).to eq(true)
#     expect(Video.count).to eq(0)
#   end


end