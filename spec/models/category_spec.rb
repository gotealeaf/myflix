require 'spec_helper'

describe Category do

  it { should validate_presence_of(:name) }
  
  it { should have_many(:videos).through(:video_categories) }  
  
  describe "#show_recent" do
    it "returns only 6 videos if there are more than 6 for that category" do
      sci_fi = Category.create(name: "Sci-fi")
      star_wars = Video.create(title: "Star Wars", description: "A great movie!", created_at: 3.day.ago)
      star_wars.categories << sci_fi
      star_trek = Video.create(title: "Star Trek", description: "A fine movie!", created_at: 5.day.ago)
      star_trek.categories << sci_fi
      tron = Video.create(title: "Tron", description: "A quirky movie!", created_at: 1.day.ago)
      tron.categories << sci_fi
      the_matrix = Video.create(title: "The Matrix", description: "An awesome movie!", created_at: 4.day.ago)
      the_matrix.categories << sci_fi
      the_terminator = Video.create(title: "The Terminator", description: "A violent movie!", created_at: 7.day.ago)
      the_terminator.categories << sci_fi
      spaceballs = Video.create(title: "Spaceballs", description: "A funny movie!", created_at: 6.day.ago)
      spaceballs.categories << sci_fi
      the_black_hole = Video.create(title: "The Black Hole", description: "An old movie!", created_at: 2.day.ago)
      the_black_hole.categories << sci_fi
      expect(sci_fi.show_recent.count).to eq(6)
    end
    it "returns all videos if there are less than 6 in that category" do
      sci_fi = Category.create(name: "Sci-fi")
      star_wars = Video.create(title: "Star Wars", description: "A great movie!", created_at: 3.day.ago)
      star_wars.categories << sci_fi
      star_trek = Video.create(title: "Star Trek", description: "A fine movie!", created_at: 5.day.ago)
      star_trek.categories << sci_fi
      tron = Video.create(title: "Tron", description: "A quirky movie!", created_at: 1.day.ago)
      tron.categories << sci_fi
      the_matrix = Video.create(title: "The Matrix", description: "An awesome movie!", created_at: 4.day.ago)
      the_matrix.categories << sci_fi
      expect(sci_fi.show_recent).to match_array(Video.all.order(created_at: :desc))
    end
    it "returns the 6 most recent videos in reverse chronological order - most recent first" do
      sci_fi = Category.create(name: "Sci-fi")
      star_wars = Video.create(title: "Star Wars", description: "A great movie!", created_at: 3.day.ago)
      star_wars.categories << sci_fi
      star_trek = Video.create(title: "Star Trek", description: "A fine movie!", created_at: 5.day.ago)
      star_trek.categories << sci_fi
      tron = Video.create(title: "Tron", description: "A quirky movie!", created_at: 1.day.ago)
      tron.categories << sci_fi
      the_matrix = Video.create(title: "The Matrix", description: "An awesome movie!", created_at: 4.day.ago)
      the_matrix.categories << sci_fi
      the_terminator = Video.create(title: "The Terminator", description: "A violent movie!", created_at: 7.day.ago)
      the_terminator.categories << sci_fi
      spaceballs = Video.create(title: "Spaceballs", description: "A funny movie!", created_at: 6.day.ago)
      spaceballs.categories << sci_fi
      the_black_hole = Video.create(title: "The Black Hole", description: "An old movie!", created_at: 2.day.ago)
      the_black_hole.categories << sci_fi
      expect(sci_fi.show_recent).to eq([tron, the_black_hole, star_wars, the_matrix, star_trek, spaceballs])
    end
    it "returns an empty array if there are no videos in that category" do
      sci_fi = Category.create(name: "Sci-fi")
      expect(sci_fi.show_recent).to eq([])
    end
  end
  
end