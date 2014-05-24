require 'spec_helper'

describe Category do
  it { should have_many(:videos)}
=begin
replaced with shoulda matcher
  it "has many videos" do
    comedies = Category.create(name: "comedies")
    south_park = Video.create(title: "South Park", description: "Funny kids", category: comedies)
    futurama = Video.create(title: "Futurama", description: "space travel", category: comedies)
    expect(comedies.videos).to eq([futurama, south_park])
  end
=end  
end
