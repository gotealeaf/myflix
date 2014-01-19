require 'spec_helper'

describe Video do
  it {should belong_to(:category)}
  it {should validate_presence_of(:name)}
 it  {should validate_presence_of(:description)}

describe "search_by_name"  do
  it "returns an empty array if there is no match" do
   futurama = Video.create(name: "Futurama", description: "Space Travel!")
   back_to_future = Video.create(name: "Back to Future", description: "TIme Travel!")
   expect(Video.search_by_name("hello")).to eq([])
 end

  it "returns an array of one video for exact match" do
   futurama = Video.create(name: "Futurama", description: "Space Travel!")
   back_to_future = Video.create(name: "Back to Future", description: "TIme Travel!")
   expect(Video.search_by_name("Futurama")).to eq([futurama])
 end

  it "returns an array of one video for partial match" do 
   futurama = Video.create(name: "Futurama", description: "Space Travel!")
   back_to_future = Video.create(name: "Back to Future", description: "TIme Travel!")
   expect(Video.search_by_name("urama")).to eq([futurama])
 end
  it "returns an array of all matches ordered by created_at" do 
   futurama = Video.create(name: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
   back_to_future = Video.create(name: "Back to Future", description: "TIme Travel!")
   expect(Video.search_by_name("Futur")).to eq([back_to_future, futurama])
 end

  it "returns an empty array for search of empty  string" do
   futurama = Video.create(name: "Futurama", description: "Space Travel!", created_at: 1.day.ago)
   back_to_future = Video.create(name: "Back to Future", description: "TIme Travel!")
   expect(Video.search_by_name("")).to eq([])
 end
  end
end

