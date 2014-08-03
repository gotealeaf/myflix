require 'spec_helper'

describe Review do
  it "has a content" do
    review = Review.new(rating: 4, content: "Best movie ever.")
    expect(review.content).to eq("Best movie ever.")
  end
  it "has a rating" do
    review = Review.new(rating: 4, content: "Best movie ever.")
    expect(review.rating).to eq(4)
  end
  it { should belong_to(:video) }

  it { should belong_to(:user) }


  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:content) }


end