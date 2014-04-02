require 'spec_helper'

describe Video do
  it 'should save itself' do
    video = Video.new(title: 'South Park', description: 'Funny stuff')
    video.save
    expect(Video.first).to eq(video)
  end
end

