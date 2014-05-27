require 'spec_helper'

describe Category do

 # it "saves itself" do                      #THERE ARE THREE STEPS TO WRITE A TEST
 #   category = Category.new(name: "comedies")  #setup or stage the test data
 #   category.save                              #perform action
 #   expect(Category.first).to eq(category)       #verify the result

 # end


  it {should have_many(:videos)} #shoulda-matchers
  it {should validate_presence_of(:name)}

  describe "#recent_videos" do  # the # is the convention to show that a method is being tested
    it "should return a blank array if there are no videos in a category" do
      cat = Category.create(name: "comedy")

      chak = Video.create(title: "chak_de", description: "chak de description")
      monk = Video.create(title: "monk", description: "monk description")
      south_park = Video.create(title: "south_park", description: "south park description")
      expect(cat.recent_videos).to eq([])
    end

    it "should return videos in reverse chronological order" do
      cat = Category.create(name: "comedy")

      chak = Video.create(title: "chak_de", description: "chak de description", category: cat, created_at: 1.day.ago)
      monk = Video.create(title: "monk", description: "monk description", category: cat)
      expect(cat.recent_videos).to eq([monk, chak])

    end

    it "should return an array of all the videos if there are less than 6 videos" do
      cat = Category.create(name: "comedy")
      chak = Video.create(title: "chak_de", description: "chak de description", category: cat, created_at: 2.days.ago)
      monk = Video.create(title: "monk", description: "monk description", category: cat, created_at: 1.day.ago)
      south_park = Video.create(title: "south_park", description: "south park description", category: cat, created_at: 10.minutes.ago)
      expect(cat.recent_videos.count).to eq(3)

    end


    it "should return an array of 6 videos in a category if there are more than 6 videos in a category" do
      cat = Category.create(name: "comedy")
      chak = Video.create(title: "chak_de", description: "chak de description", category: cat, created_at: 2.days.ago)
      monk = Video.create(title: "monk", description: "monk description", category: cat, created_at: 1.day.ago)
      south_park = Video.create(title: "south_park", description: "south park description", category: cat, created_at: 100.minutes.ago)
      avatar = Video.create(title: "avatar", description: "chak de description", category: cat, created_at: 3.days.ago)
      family = Video.create(title: "family", description: "monk description", category: cat, created_at: 10.day.ago)
      thor = Video.create(title: "thor", description: "south park description", category: cat, created_at: 5.minutes.ago)
      futurama = Video.create(title: "futurama", description: "south park description", category: cat, created_at: 1.minute.ago)
      
      expect(cat.recent_videos).to eq([futurama, thor, south_park, monk, chak, avatar])
    end

    it "should return the most recent 6 videos" do
      cat = Category.create(name: "comedy")
      6.times {Video.create(title: "foo", description: "bar", category: cat)}
      monk = Video.create(title: "monk", description: "monk description", category: cat, created_at: 1.day.ago)
      
      expect(cat.recent_videos).to_not include(monk)   

    end

  end

#Following code for writing the test line by line
  #it "has many videos" do
  #  comedies = Category.create(name: "comedy")
  #  monk = Video.create(title: "abc", description: "abc desc", category_id: comedies.id)
  #  family_guy = Video.create(title: "ab",description: "ab desc", category_id: comedies.id)
  #  expect(comedies.videos).to include(monk, family_guy)
  #end

end