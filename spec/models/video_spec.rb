require 'spec_helper'

describe Video do
  it "should save a new video" do
    video = Video.create!(title: 'Titanic', 
                         description: 'An emotional movie',
                         small_cover_url: '/tmp/family_guy.jpg', 
                         large_cover_url: '/tmp/monk_large.jpg' )
    expect(video.title).to eq 'Titanic'
  end

  it "should return an empty array for a non-matching title" do
    video = Video.create!(title: 'Titanic', 
                         description: 'An emotional movie',
                         small_cover_url: '/tmp/family_guy.jpg', 
                         large_cover_url: '/tmp/monk_large.jpg' )
    expect(Video.search_by_title("Man")).to eq []
  end

  it "should return an array with one element for one matching title" do
    video = Video.create!(title: 'Titanic', 
                         description: 'An emotional movie',
                         small_cover_url: '/tmp/family_guy.jpg', 
                         large_cover_url: '/tmp/monk_large.jpg' )
    expect(Video.search_by_title("Titanic")).to eq [video]
  end

  it "should return an array with multiple elements for multiple matching titles" do
    video1 = Video.create!(title: 'Arc of Egypt', 
                         description: 'An emotional movie',
                         small_cover_url: '/tmp/family_guy.jpg', 
                         large_cover_url: '/tmp/monk_large.jpg' )

    video2 = Video.create!(title: "Jonah's Arc", 
                         description: 'An emotional movie',
                         small_cover_url: '/tmp/family_guy.jpg', 
                         large_cover_url: '/tmp/monk_large.jpg' )

    expect(Video.search_by_title("Arc")).to eq [video1, video2]
  end

  it { should belong_to(:category) } 
  it { should validate_presence_of(:title) } 
  it { should validate_presence_of(:description) } 
end
