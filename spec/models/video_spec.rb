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
      Video.search_by_title("Frozen").should == []
    end

    it "returns 1 array result if no match" do
      monk = Video.find_by_title("Monk")

      Video.search_by_title("Monk").should == [monk]
    end

    it "with 'F' should find 2 result" do
      family_guy = Video.find_by_title("Family Guy")
      futurama   = Video.find_by_title("Futurama")

      Video.search_by_title("F").should == [family_guy, futurama]
    end

    it "returns empty array if search keyword is empty string" do
      Video.search_by_title("").should == []
    end
  end
end
