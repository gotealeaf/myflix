require 'spec_helper'
require 'shoulda/matchers'
 
describe Video do
  it { should belong_to :category }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }

  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      futurama = Video.create(title: "Futurama", description: "Gotham needs a hero.")
      back_to_future = Video.create(title: "Back to Future", description: "Gotham needs a hero.")
      expect(Video.search_by_title("hello")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: "Futurama", description: "Gotham needs a hero.")
      back_to_future = Video.create(title: "Back to Future", description: "Gotham needs a hero.")
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end 

    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "Futurama", description: "Gotham needs a hero.")
      back_to_future = Video.create(title: "Back to Future", description: "Gotham needs a hero.")
      expect(Video.search_by_title("uturama")).to eq([futurama])
    end

    it "returns an array of all matched ordered by created_at" do
      futurama = Video.create(title: "Futurama", description: "Gotham needs a hero.", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Gotham needs a hero.")
      expect(Video.search_by_title("Futur")).to eq([back_to_future, futurama])
    end

    it "returns an empty array for a search with an empty string" do
      futurama = Video.create(title: "Futurama", description: "Gotham needs a hero.", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future", description: "Gotham needs a hero.")
      expect(Video.search_by_title("")).to eq([])
    end
  end

end
  # More concise above using gem "shoulda_matchers"

  # it "belongs to category" do
  #   soaps = Category.create(name: "Soaps")
  #   batman = Video.create(title: "Batman", description: "Gotham needs a hero.", category: soaps)
  #   expect(batman.category).to eq(soaps)
  # end

  # it "should validate presence of :title" do
  #   expect(subject).to validate_presence_of :title
  # end

  # it "should validate presence of :description" do
  #   expect(subject).to validate_presence_of :description
  # end

  # solution w/o shoulda_matchers

  # it "does not save a video without a title" do
  #   video = Video.create(description: "a great movie!")
  #   expect(Video.count).to eq(0)
  # end

  # it "does not save a video without a dexsription" do
  #   video = Video.create(title: "monk")
  #   expect(Video.count).to eq(0)
  # end

  # below is I found on Stackoverflow, to test with error quatity

  # it "must have a title" do    
  #   subject.valid?
  #   expect(subject.errors[:title].size).to eq(1)
  # end

  # it "must have a description" do
  #   subject.valid?
  #   expect(subject.errors[:description].size).to eq(1)
  # end

  # In fact, we don't test on Rails itself.

  # it "saves itself" do
  #   video = Video.new(title: "Batman", description: "Gotham needs a hero.")
  #   video.save
  #   expect(Video.last).to eq(video)
  #   # 'should' is still available, but rspec core team suggest above. 'should ==' is called rspec matcher
  #   # Video.last.title.should == "Batman"
  #   # Video.last.title.should eq(video)
  # end