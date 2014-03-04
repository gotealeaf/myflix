require 'spec_helper'

describe Category do

 # it "saves itself" do                      #THERE ARE THREE STEPS TO WRITE A TEST
 #   category = Category.new(name: "comedies")  #setup or stage the test data
 #   category.save                              #perform action
 #   expect(Category.first).to eq(category)       #verify the result

 # end


  it {should have_many(:videos)} #shoulda-matchers


#Following code for writing the test line by line
  #it "has many videos" do
  #  comedies = Category.create(name: "comedy")
  #  monk = Video.create(title: "abc", description: "abc desc", category_id: comedies.id)
  #  family_guy = Video.create(title: "ab",description: "ab desc", category_id: comedies.id)
  #  expect(comedies.videos).to include(monk, family_guy)
  #end

end