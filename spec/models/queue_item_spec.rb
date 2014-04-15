require 'spec_helper'

describe QueueItem do
  before do
    @user = Fabricate(:user)
    @video = Fabricate(:video, category: Fabricate(:category) )
    @review = Fabricate(:review, user: @user, video: @video, rating: 3)
    @queue_item = QueueItem.create(user: @user, video: @video)
    @queue_item_no_review = Fabricate(:queue_item_no_review)
  end
  it "returns video title" do
    expect(@queue_item.video_title).to eq @video.title
  end
  it "returns category's name" do
    expect(@queue_item.category_name).to eq @video.category.name
  end
  it "returns rating when review exist" do
    expect(@queue_item.rating).to eq @review.rating
  end
  it "makes rating function returns nil when no review" do
    expect(@queue_item_no_review.rating).to eq nil
     
  end
  it "saves rating" do
    @queue_item.save_rating(2)
    expect(@queue_item.rating).to eq 2
  end
end

