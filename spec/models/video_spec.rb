require 'spec_helper'

describe Video do

	it { should belong_to(:category)}
	it { should validate_presence_of(:title)}
	it { should validate_presence_of(:description)}



	# it "saves itself" do
	# 	v = Video.create(title: "F1", small_cover_url: "F1.jpg", large_cover_url: "F1.jpg",  description: "F1")

 	# 		# Rspec prefer this one
	# 		expect(Video.first).to eq(v)	 		
 	#  end 	 

 	#  it "belongs to category" do
 	#  		dramas = Category.create(name: "dramas")
 	#  		monk = Video.create(title: "monk", description: "5 star Video", category: dramas)
			
 	#  		expect(monk.category).to eq(dramas)
  # end

  # it "leave blank in title within a video" do
  # 	video = Video.create(description: "hungry marketing")
  # 	 expect(Video.count).to eq(0)
  # end

  # it "leave blank in description within a video" do 
  # 	video = Video.create(title: "XiaoMi")
  # 	expect(Video.count).to eq(0)
  # end

end
