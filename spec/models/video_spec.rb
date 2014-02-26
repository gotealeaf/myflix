require 'spec_helper'

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe ".search_by_title(search_term)" do
    it "should return an empty array if it finds no videos"
    it "should return an array of one video if it is an exact match"
    it "should return an array of one video for a partial match"
    it "should return an array of all videos" 
  end

end


