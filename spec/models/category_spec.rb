require 'spec_helper'

  describe Category do
    it { should have_many(:videos) }
    
    describe "#recent_videos" do
      it "returns an array of all sorted by created_at if <6" do
        comedies = Category.create(name: "Comedies")
        monk = Video.create(title: "Monk", description: "OCD TV.  This is a show about a clean-cut man who likes to be clean.  Too clean, some would say.  Buy now!", small_url: "/tmp/monk.jpg" , large_url: "/tmp/monk_large.jpg", category: comedies)
        family_guy = Video.create(title: "Family Guy", description: "A comedy if you live in an upper-middle class suburb of create York.  Otherwise, a mystery.  Buy now!" , small_url: "/tmp/family_guy.jpg", category: comedies)
        futurama = Video.create(title: "Futurama", description: "How people from the early 2000s viewed the future we now live in." , small_url: "/tmp/futurama.jpg", category: comedies)
        south_park = Video.create(title: "South Park", description: "A true, heartwarming story about society's ignorance." , small_url: "/tmp/south_park.jpg", category: comedies)

        expect(comedies.recent_videos).to eq([south_park, futurama, family_guy, monk])
      end

      it "returns an array of the last 6 sorted by created_at if >6" do
        comedies = Category.create(name: "Comedies")
        monk = Video.create(title: "Monk", description: "OCD TV.  This is a show about a clean-cut man who likes to be clean.  Too clean, some would say.  Buy now!", small_url: "/tmp/monk.jpg" , large_url: "/tmp/monk_large.jpg", category: comedies)
        family_guy = Video.create(title: "Family Guy", description: "A comedy if you live in an upper-middle class suburb of create York.  Otherwise, a mystery.  Buy now!" , small_url: "/tmp/family_guy.jpg", category: comedies)
        futurama = Video.create(title: "Futurama", description: "How people from the early 2000s viewed the future we now live in." , small_url: "/tmp/futurama.jpg", category: comedies)
        south_park1 = Video.create(title: "South Park", description: "A true, heartwarming story about society's ignorance." , small_url: "/tmp/south_park.jpg", category: comedies)
        south_park2 = Video.create(title: "South Park", description: "A true, heartwarming story about society's ignorance." , small_url: "/tmp/south_park.jpg", category: comedies)
        south_park3 = Video.create(title: "South Park", description: "A true, heartwarming story about society's ignorance." , small_url: "/tmp/south_park.jpg", category: comedies)

        expect(comedies.recent_videos).to eq([south_park3, south_park2, south_park1, futurama, family_guy, monk])

      end

        it "returns an empty array for an empty category" do
        comedies = Category.create(name: "Comedies")
        expect(comedies.recent_videos).to eq([])

      end

    end

  end




  # it "has many videos" do
  #   video2 = Video.new(title: "Godfather II", description: "Due")
  #   video3 = Video.new(title: "Godfather III", description: "Tre")
  #   video2.save
  #   video3.save
  #   category = Category.new(name: "Mafia")
  #   category.videos << video2
  #   category.videos << video3
  #   category.save
  #   expect(category.videos.size).to eq(2)
  # end


