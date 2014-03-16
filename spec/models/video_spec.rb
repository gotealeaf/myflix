require "spec_helper"

describe Video do
  it { should belong_to(:category) }
  it { should have_many(:reviews) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  context "search_by_title" do
    before(:each) do
      Video.create(title: "Monk",     description: "Monk")
      Video.create(title: "Family Guy",   description: "Family Guy")
      Video.create(title: "Futurama", description: "Futurama")
    end

    it "returns empty array result if no match" do
      expect(Video.search_by_title("Frozen")).to eq([])
    end

    it "returns 1 array result if exactly 1 match" do
      monk = Video.find_by_title("Monk")

      expect(Video.search_by_title("Monk")).to eq([monk])
    end

    it "with 'F' should find 2 result" do
      family_guy = Video.find_by_title("Family Guy")
      futurama   = Video.find_by_title("Futurama")

      expect(Video.search_by_title("F")).to eq([family_guy, futurama])
    end

    it "returns empty array if search keyword is empty string" do
      expect(Video.search_by_title("")).to eq([])
    end
  end
end
