require "spec_helper"

describe Category do
  it { should have_many(:videos) }

  context "recent_videos" do
    before(:each) do
      animation = Category.create(name: "Animation")
      dramas    = Category.create(name: "TV Dramas")
      reality   = Category.create(name: "Reality TV")

      animation.videos.create(title: "Frozen",                  description: "Disney cartoon Frozen", created_at: 1.minutes.ago)
      animation.videos.create(title: "Car",                     description: "Disney cartoon Car")
      animation.videos.create(title: "Toy Story",               description: "Disney cartoon Toy Story")
      animation.videos.create(title: "Finding Nemo",            description: "Disney cartoon Finding Nemo")
      animation.videos.create(title: "Attack on titan",         description: "Japanese animaiton Attack on titan")
      animation.videos.create(title: "Neon Genesis Evangelion", description: "Japanese animaiton Neon Genesis Evangelion")
      animation.videos.create(title: "Detective Conan",         description: "Japanese animaiton Detective Conan")

      dramas.videos.create(title: "Game of Thrones", description: "TV Drama Game of Thrones", created_at: 2.days.ago)
      dramas.videos.create(title: "Sherlock",        description: "TV Drama Sherlock",        created_at: 1.day.ago)
      dramas.videos.create(title: "The Sopranos",    description: "TV Drama The Sopranos",    created_at: 3.days.ago)
    end

    it "returns videos in created_at desc order" do
      dramas = Category.find_by_name("TV Dramas")

      game_of_thrones = Video.find_by_title("Game of Thrones")
      sherlock        = Video.find_by_title("Sherlock")
      the_sopranos    = Video.find_by_title("The Sopranos")

      expect(dramas.recent_videos).to eq([sherlock, game_of_thrones, the_sopranos])
    end

    it "returns only 6 videos if there are more than 6" do
      animation = Category.find_by_name("Animation")
      expect(animation.recent_videos.size).to eq(6)
    end

    it "returns all of the videos if there are less than 6" do
      dramas = Category.find_by_name("TV Dramas")
      expect(dramas.recent_videos.size).to eq(3)
    end

    it "doesn't include the 7th recent video" do
      animation = Category.find_by_name("Animation")
      frozen = Video.find_by_title("Frozen")

      expect(animation.recent_videos).not_to include(frozen)
    end

    it "returns an empty array if the category does not have any videos" do
      reality = Category.find_by_name("Reality TV")
      expect(reality.recent_videos).to eq([])
    end
  end
end
