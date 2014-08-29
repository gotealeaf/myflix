require 'spec_helper'

describe Category do

   it { should have_many(:videos) }


  describe "find recent videos do" do

    it "searches and finds no videos when none exist" do
      thrillers = Category.create(name: "Thrillers")
      cartoons = Category.create(name: "Cartoons")
      winkle = Video.create(title: "Bullwinkle", description: "Moose Story", category: cartoons)
      moose = Video.create(title: "Bullwinkle", description: "Moose movie")

      recent_thrillers = thrillers.recent_videos
      expect(recent_thrillers.count).to eq(0)
    end

    it "searches and finds six videos in title order when a lot of videos" do
      cartoons = Category.create(name: "Cartoons")
      moose = Video.create(title: "zBullwinkle", description: "Moose movie", category: cartoons)
      rage = Video.create(title: "yRaging Bull", description: "Boxing movie", category: cartoons)
      squirrel = Video.create(title: "sRocky", description: "not Rambo", category: cartoons)
      hocky = Video.create(title: "hHocky", description: "not Rambo", category: cartoons)
      docky = Video.create(title: "dDocky", description: "not Rambo", category: cartoons)
      socky = Video.create(title: "bSocky", description: "not Rambo", category: cartoons)
      locky = Video.create(title: "arLcky", description: "not Rambo", category: cartoons)

      recent_cartoons = cartoons.recent_videos
      expect(recent_cartoons).to eq([locky,socky,docky,hocky, squirrel,rage])

    end
  end






=begin
  it "saves itself" do
    category = Category.new(name: "Thrillers")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has videos" do
    thrillers = Category.create(name: "Thrillers")

    winkle = Video.create(title: "Bullwinkle", description: "Moose Story", category: thrillers)
    bodyheat = Video.create(title: "Body Heat", description: "sultry", category: thrillers)

    expect(thrillers.videos).to eq([bodyheat, winkle])
  end
=end



end
