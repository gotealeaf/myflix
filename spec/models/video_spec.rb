require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "takes in a string as an argument and returns an empty array if the string does not match any titles" do
      search = "unmatched_title"
      expect(Video.search_by_title(search)).to eq([])
    end
    it "takes in a string as an argument and returns a single-element array containing a video if the string matches one title" do
      @eleven_am = Time.parse("2011-1-2 11:00:00")
      Time.stub(:now) { @eleven_am }
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.", created_at: @eleven_am, updated_at: @eleven_am)
      search = "futurama"
      expect(Video.search_by_title(search)).to eq([futurama])
    end
    it "takes in a string as an argument and returns an array containing multiple videos if the string matches more than one title" do
      @eleven_am = Time.parse("2011-1-2 11:00:00")
      Time.stub(:now) { @eleven_am }
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.", created_at: @eleven_am, updated_at: @eleven_am)
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.", created_at: @eleven_am, updated_at: @eleven_am)
      family_comedy = Video.create(title: "Family Comedy", description: "So generic! etc.", created_at: @eleven_am, updated_at: @eleven_am)
      search = "family"
      expect(Video.search_by_title(search)).to eq([family_guy, family_comedy])
    end
    it "takes in a string as an argument and returns an array containing multiple videos if the string matches more than one title" do
      @eleven_am = Time.parse("2011-1-2 11:00:00")
      Time.stub(:now) { @eleven_am }
      futurama = Video.create(title: "Futurama", description: "Philip J. Fry etc.", created_at: @eleven_am, updated_at: @eleven_am)
      family_guy = Video.create(title: "Family Guy", description: "Peter Griffin etc.", created_at: @eleven_am, updated_at: @eleven_am)
      family_comedy = Video.create(title: "Family Comedy", description: "So generic! etc.", created_at: @eleven_am, updated_at: @eleven_am)
      search = "guy"
      expect(Video.search_by_title(search)).to eq([family_guy])
    end
  end
end