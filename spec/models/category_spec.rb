require 'spec_helper'

describe Category do
  it 'save itself' do
   category = Category.new(name: "comedies")
   category.save
   expect(Category.first).to eq(category) 
  end
  it 'has many videos' do
    sports = Category.create(name:"Sports")
    nba = Video.create(title:"NBA", description: "NBA games",category: sports)
    football = Video.create(title:"Football", description:"A fotoball game",category: sports)
    expect(sports.videos).to eq([football,nba])
  end
end