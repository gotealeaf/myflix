require 'spec_helper'

describe Category do
  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "returns an empty array if there are no videos" do
      comedy = Category.create(name: "Comedy")

      expect(comedy.recent_videos).to eq([])
    end

    it "returns videos in reverse chronlogical order by updated at" do
      comedy = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "A loud drunk father.", category: comedy, updated_at: 2.day.ago )
      futurama = Video.create(title: "Futurama", description: "An pizza delievery boy gets frozen.", category: comedy)

      expect(comedy.recent_videos).to eq([futurama, family_guy])
    end

    it "returns an array of all videos if fewer than 6" do
      comedy = Category.create(name: "Comedy")
      family_guy = Video.create(title: "Family Guy", description: "A loud drunk father.", category: comedy)
      futurama = Video.create(title: "Futurama", description: "An pizza delievery boy gets frozen.", category: comedy)

      expect(comedy.recent_videos).to match_array([family_guy, futurama])
    end

    it "returns 6 videos if there are more than 6 videos" do
      comedy = Category.create(name: "Comedy")
      7.times { Video.create(title: "foo", description: "bar", category: comedy) }

      expect(comedy.recent_videos.count).to eq(6)
    end

    it "returns most recent 6 videos" do
      comedy = Category.create(name: "Comedy")
      futurama = Video.create(title: "Futurama", description: "An pizza delievery boy gets frozen.", category: comedy, updated_at: 6.day.ago)
      back_to_the_future = Video.create(title: "Back to the Future", description: "Back in time!", category: comedy, updated_at: 3.day.ago)
      the_simpsons = Video.create(title: "The Simpsons", description: "Yellow people.", category: comedy, updated_at: 4.day.ago)
      south_park = Video.create(title: "South Park", description: "Some kids cause trouble.", category: comedy, updated_at: 5.day.ago)
      king_of_the_hill = Video.create(title: "King of the Hill", description: "Some Texians.", category: comedy, updated_at: 2.day.ago)
      modern_family = Video.create(title: "Modern Family", description: "A very funny modern famiyl.", category: comedy, updated_at: 1.day.ago)

      expect(comedy.recent_videos).to eq([modern_family, king_of_the_hill, back_to_the_future, the_simpsons, south_park, futurama])
    end
  end
end