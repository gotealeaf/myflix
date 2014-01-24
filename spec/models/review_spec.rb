require 'spec_helper'

describe Review do
  it { should belong_to(:video) }
  it { should belong_to(:user) }

  it "should validate the presence of the body" do
    Review.create(rating: 3, video: Fabricate(:video), user: Fabricate(:user))
    expect(Review.all.count).to eq(0)
  end
  it "should validate the presence of the rating" do
    Review.create(body: "hello", video: Fabricate(:video), user: Fabricate(:user))
    expect(Review.all.count).to eq(0)
  end
  it "creates the review if body and rating are present" do
    Review.create(body: "hello", rating: 3, video: Fabricate(:video), user: Fabricate(:user))
    expect(Review.all.count).to eq(1)
  end
end