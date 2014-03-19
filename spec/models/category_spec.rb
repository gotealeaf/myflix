require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do
    it "should return an empty array if the category contains no videos" do
      category = Category.create(name: "TV Comedies")
      expect(category.recent_videos).to eq([])
    end
    
    it "should return the videos within a category if the category contains videos" do
      category = Category.create(name: "TV Comedies")
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.", category_id: category.id, created_at: 1.day.ago)
      futurama = Video.create(title: "Futurama", description: "Philip Fry etc.", category_id: category.id, created_at: 2.days.ago)
      expect(category.recent_videos).to eq([family_guy, futurama])
    end

    it "should return the videos within a category sorted by date created with most recent video first" do
      category = Category.create(name: "TV Comedies")
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.", category_id: category.id, created_at: 1.day.ago)
      futurama = Video.create(title: "Futurama", description: "Philip Fry etc.", category_id: category.id, created_at: 2.days.ago)
      simpsons = Video.create(title: "Simpsons", description: "Matt Groening etc.", category_id: category.id, created_at: 3.day.ago)
      south_park = Video.create(title: "South Park", description: "Fourth graders etc.", category_id: category.id, created_at: 4.days.ago)
      monk = Video.create(title: "Monk", description: "OCD detective etc.", category_id: category.id, created_at: 5.day.ago)
      archer = Video.create(title: "Archer", description: "Spy comedy etc.", category_id: category.id, created_at: 6.days.ago)
      expect(category.recent_videos).to eq([family_guy, futurama, simpsons, south_park, monk, archer])
    end

    it "should return only the most recently created 6 videos in a category if the category contains more than 6 videos" do
      category = Category.create(name: "TV Comedies")
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.", category_id: category.id, created_at: 1.day.ago)
      futurama = Video.create(title: "Futurama", description: "Philip Fry etc.", category_id: category.id, created_at: 2.days.ago)
      simpsons = Video.create(title: "Simpsons", description: "Matt Groening etc.", category_id: category.id, created_at: 3.day.ago)
      south_park = Video.create(title: "South Park", description: "Fourth graders etc.", category_id: category.id, created_at: 4.days.ago)
      monk = Video.create(title: "Monk", description: "OCD detective etc.", category_id: category.id, created_at: 5.day.ago)
      archer = Video.create(title: "Archer", description: "Spy comedy etc.", category_id: category.id, created_at: 6.days.ago)
      bobs_burgers = Video.create(title: "Bob's Burgers", description: "H Jon Benjamin etc.", category_id: category.id, created_at: 7.day.ago)
      expect(category.recent_videos).to eq([family_guy, futurama, simpsons, south_park, monk, archer])
    end
  end
end

    