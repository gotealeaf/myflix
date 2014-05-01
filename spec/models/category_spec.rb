require 'spec_helper'

describe Category do
  it { should have_many(:videos) }
end

describe "#recent_videos" do
  
  it "returns the most recent videos ordered by latest video first" do
    comedy = Category.create(name: "comedy")
    robocop = Video.create(title: "Robocop", description: "Action movie", created_at: 1.day.ago)
    cops_and_robbers = Video.create(title: "Cops and robbers", description: "Police story", created_at: 2.days.ago)
    futurama = Video.create(title: "Futurama", description: "Not bad", created_at: 1.week.ago)
    robocop.categories << comedy
    cops_and_robbers.categories << comedy
    futurama.categories << comedy
    expect(comedy.recent_videos).to eq([robocop, cops_and_robbers, futurama])
  end
  
  it "returns all the videos if there are less than 6 present" do
    comedy = Category.create(name: "comedy")
    robocop = Video.create(title: "Robocop", description: "Action movie", created_at: 1.day.ago)
    cops_and_robbers = Video.create(title: "Cops and robbers", description: "Police story", created_at: 2.days.ago)
    futurama = Video.create(title: "Futurama", description: "Not bad", created_at: 1.week.ago)
    robocop.categories << comedy
    cops_and_robbers.categories << comedy
    futurama.categories << comedy
    expect(comedy.recent_videos.count).to eq(3)
  end
  
  it "returns 6 videos if there are more than 6 videos present" do
    comedy = Category.create(name: "comedy")
    robocop = Video.create(title: "Robocop", description: "Action movie")
    cops_and_robbers = Video.create(title: "Cops and robbers", description: "Police story")
    futurama = Video.create(title: "Futurama", description: "Not bad")
    robocop2 = Video.create(title: "Robocop", description: "Action movie")
    cops_and_robbers2 = Video.create(title: "Cops and robbers", description: "Police story")
    futurama2 = Video.create(title: "Futurama", description: "Not bad")
    futurama3 = Video.create(title: "Futurama", description: "Not bad")
    robocop.categories << comedy
    cops_and_robbers.categories << comedy
    futurama.categories << comedy
    robocop2.categories << comedy
    cops_and_robbers2.categories << comedy
    futurama2.categories << comedy
    futurama3.categories << comedy
    expect(comedy.recent_videos.count).to eq(6)
  end
  
  it "returns the most recent 6 videos" do
    comedy = Category.create(name: "comedy")
    robocop = Video.create(title: "Robocop", description: "Action movie", created_at: 1.day.ago)
    cops_and_robbers = Video.create(title: "Cops and robbers", description: "Police story", created_at: 2.days.ago)
    futurama = Video.create(title: "Futurama", description: "Not bad", created_at: 3.days.ago)
    robocop2 = Video.create(title: "Robocop", description: "Action movie", created_at: 4.days.ago)
    cops_and_robbers2 = Video.create(title: "Cops and robbers", description: "Police story", created_at: 5.days.ago)
    futurama2 = Video.create(title: "Futurama", description: "Not bad", created_at: 6.days.ago)
    futurama3 = Video.create(title: "Futurama", description: "Not bad", created_at: 1.week.ago)
    robocop.categories << comedy
    cops_and_robbers.categories << comedy
    futurama.categories << comedy
    robocop2.categories << comedy
    cops_and_robbers2.categories << comedy
    futurama2.categories << comedy
    futurama3.categories << comedy
    expect(comedy.recent_videos).not_to include([futurama3])
  end
  
  it "returns an empty array if there are no videos in the category" do
    comedy = Category.create(name: "comedy")
    expect(comedy.recent_videos).to eq([])
  end
end
