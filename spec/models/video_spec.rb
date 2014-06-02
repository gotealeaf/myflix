require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  describe '.search_by_title' do
    it 'return an empty array if there is no match in the database table' do
      spiderman = Video.create(title: "Spiderman", description: "A spiderman")
      superman = Video.create(title: "Superman", description: "A superman")
      expect(Video.search_by_title("Age")).to eq([])
    end

    it 'return an array of one video for an exact match' do
      spiderman = Video.create(title: "Spiderman", description: "A spiderman")
      superman = Video.create(title: "Superman", description: "A superman")
      expect(Video.search_by_title("Spiderman")).to eq([spiderman])
    end

    it 'return an array of oen video for a partial match' do
      spiderman = Video.create(title: "Spiderman", description: "A spiderman")
      superman = Video.create(title: "Superman", description: "A superman")
      expect(Video.search_by_title("piderma")).to eq([spiderman])
    end

    it 'return an array of all matches ordered by created_at' do
      spiderman = Video.create(title: "Spiderman", description: "A spiderman",
        created_at: 1.day.ago)
      superman = Video.create(title: "Superman", description: "A superman")
      expect(Video.search_by_title("man")).to eq([superman,spiderman])
    end

    it 'return an empty array for a search with an empty string' do
      spiderman = Video.create(title: "Spiderman", description: "A spiderman",
        created_at: 1.day.ago)
      superman = Video.create(title: "Superman", description: "A superman")
      expect(Video.search_by_title("")).to eq([])
    end
  end
end