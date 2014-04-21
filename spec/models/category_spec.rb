require 'spec_helper'


	

describe Category do 
	
	it { should have_many(:videos).order(:title) }
	it { should have_many(:videos).through(:video_categories) }
	it {should validate_presence_of(:name) }


	# before do
	# 	@video_scary = Video.create(title: "Scary Movie 2", description: "Funny horror flick", large_cover_url: 'large.jpg', small_cover_url: 'small.jpg')
	# 	@video_shinning = Video.create(title: "The Shinning", description: "Horror flick", large_cover_url: 'large.jpg', small_cover_url: 'small.jpg')

		
	# end
	
	# it "saves itself" do
	# 	category = Category.new(name: "Horror")
	# 	category.save
	# 	expect(Category.first).to eq(category)

	# end


	# it "has many videos" do
	# 	category_scary   = Category.create(name: 'Scary')
		
	# 	VideoCategory.create(category: category_scary, video: @video_scary)
	# 	VideoCategory.create( category: category_scary, video: @video_shinning)


	# 	expect(category_scary.videos.count).to eq(2)
	# 	expect(category_scary.videos).to eq([@video_scary, @video_shinning	])
	# end


	
end