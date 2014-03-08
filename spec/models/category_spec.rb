require 'spec_helper'

describe Category do
  it {should have_many(:videos)}

 	 # it "saves itself" do
	 	# 	c = Category.create(name: "Racing")
		#   c.save
 		# 	# Rspec prefer this one
	 	# 	expect(Category.first).to eq(c)
 	 # end 

 	 # it "has many videos"	 do
 	 # 	c = Category.create(name: "Racing")
 	 # 	Rush = Video.create(title: "RUSH", description: "nikki lauda and james hunt", category: c )
 	 # 	FF4  = Video.create(title: "FF4", description: "Fast and Furious 4", category: c)		
 	 # 	expect(c.videos).to eq([FF4,Rush])
 	 # end
end
