require 'spec_helper'

describe Video do 
  #it "saves itself" do                      #THERE ARE THREE STEPS TO WRITE A TEST
  #  video = Video.new(title: "xyz", description: "more xyz", small_cover_url: "test short",
  #    large_cover_url: "test large cover")  #setup or stage the test data
  #  video.save                              #perform action
  #  expect(Video.first).to eq(video)       #verify the result

  #end
  
  it {should belong_to(:category)}  #using shoulda-matchers: Checking that Video belongs_to Category
  it {should validate_presence_of(:title)} #shoulda-matchers
  it {should validate_presence_of(:description)} #shoulda-matchers


  #Following code for writing the test line by line
  #it "belongs to a category" do
  #  thriller = Category.create(name: "thriller")
  #  video = Video.new(title: "xyz", description: "more xyz", small_cover_url: "test short",
  #    large_cover_url: "test large cover", category: thriller)
  #  expect(video.category).to eq(thriller)


  #end

  #it "will not save without a title" do
  #  video = Video.create( description: "abc description")
    
  #  expect(Video.count).to eq(0)

  #end

  #it "will not save without a description" do
  #  video = Video.create( title: "abc")
    
  #  expect(Video.count).to eq(0)

  #end

   

  

end