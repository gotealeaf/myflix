require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  describe "rating" do
    before do
      @user1 = Fabricate(:user)
      @video1 = Fabricate(:video)
      @queue_item1 = Fabricate(:queue_item, video: @video1, user: @user1)
    end

    it "should find the rating if there is one" do
      review1 = Fabricate(:review, video: @video1, user: @user1)
      @queue_item1.rating.should == review1.rating
    end

    it "it should return nil if the review is not present" do
      @queue_item1.rating.should be_blank
    end
  end
  ##############################################
  describe "rating=" do
    before do
      @user1 = Fabricate(:user)
      @video1 = Fabricate(:video)
      @queue_item1 = Fabricate(:queue_item, video: @video1, user: @user1)
    end

    it "should replace the rating if there is one" do
      review1 = Fabricate(:review, video: @video1, user: @user1, rating: 1)
      @queue_item1.rating= 3
      review1.reload.rating.should == 3
    end

    it "should blank out the rating" do
      review1 = Fabricate(:review, video: @video1, user: @user1, rating: 1)
      @queue_item1.rating= nil
      review1.reload.rating.should be_nil
    end


    it "it should create a review if the review is not present" do
      @queue_item1.rating = 3
      Review.count.should == 1
    end
  end
  

end
