require 'spec_helper'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:rating) }
    
  #describe "#recent_reviews" do
    #it "should show the most recent reviews first" do
      #review1 = Fabricate(:review, created_at: 1.day.ago, user: Fabricate(:user), video: Fabricate(:video))
      #review2 = Fabricate(:review, created_at: 2.days.ago, user: Fabricate(:user), video: Fabricate(:video))
      #review3 = Fabricate(:review, created_at: 3.days.ago, user: Fabricate(:user), video: Fabricate(:video)) 
      #review4 = Fabricate(:review, created_at: 4.days.ago, user: Fabricate(:user), video: Fabricate(:video))
      #review5 = Fabricate(:review, created_at: 1.week.ago, user: Fabricate(:user), video: Fabricate(:video))
      #review6 = Fabricate(:review, created_at: 2.weeks.ago, user: Fabricate(:user), video: Fabricate(:video))  
      #expect(Review.recent_review).to eq([review1, review2, review3, review4, review5, review6])
    #end
  #end
end