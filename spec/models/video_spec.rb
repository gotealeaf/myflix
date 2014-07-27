require 'spec_helper'

describe Video do
  it 'saves itself' do
    video = Video.new(title: 'Monk', description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.', small_cover_url: 'tmp/monk.jpg', large_cover_url: 'tmp/monk_large.jpg', category_id: 2)
    video.save
    expect(Video.first).to eq(video)
  end
end