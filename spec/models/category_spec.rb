require 'spec_helper'

describe Category do
  it { should have_many(:videos)}

  describe "#recent_videos" do
    it 'returns the videos in the reverse chronical order by created at' do
      comedies = Category.create(category: 'comedies')
      futurama = Video.create(title: "Futurama", description: "Space Travel!", category: comedies)
      south_park = Video.create(title: "South Park", description: "Crazy Kids!", category: comedies)
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it 'returns all the videos if there are less than 6 videos'do
      comedies = Category.create(category: 'comedies')
      futurama = Video.create(title: "Futurama", description: "Space Travel!", category: comedies)
      south_park = Video.create(title: "South Park", description: "Crazy Kids!", category: comedies)
      expect(comedies.recent_videos.count).to eq(2)
    end

    it 'returns all the videos if there are more than 6 videos'do
      comedies = Category.create(category: 'comedies')
      7.times {Video.create(title: "foo", description: "Crazy Kids!", category: comedies)}
      expect(comedies.recent_videos.count).to eq(6)
    end

    it 'returns the most recent 6 videos' do
      comedies = Category.create(category: 'comedies')
      6.times {Video.create(title: "foo", description: "Crazy Kids!", category: comedies)}
      tonights_show = Video.create(title: "Tonight", description: "what was talked about tonight", category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonights_show)
    end

    it 'returns an empty arrar if the category does not have any videos'do
      comedies = Category.create(category: 'comedies')
      expect(comedies.recent_videos).to eq([])
    end
  end
end