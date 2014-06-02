require 'spec_helper'

describe Video do
  it "should save a new video" do
    video = Video.create!(title: 'Titanic', 
                         description: 'An emotional movie',
                         small_cover_url: '/tmp/family_guy.jpg', 
                         large_cover_url: '/tmp/monk_large.jpg' )
    expect(video.title).to eq 'Titanic'
  end

  it { should belong_to(:category) } 
  it { should validate_presence_of(:title) } 
  it { should validate_presence_of(:description) } 
end
