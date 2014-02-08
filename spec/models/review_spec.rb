require 'spec_helper'

describe Review do
  it {should belong_to(:user)}
  it {should belong_to(:video)}
  it {should validate_presence_of(:content)}

  describe '#has_content?' do
    context "with review present" do
      let!(:review1) { Fabricate(:review, content: "Specified Content")}
    
      it "should return false if there is no content" do
        review1.update_columns(content: nil)
        expect(Review.first.has_content?).to be_false
      end
      it "should return true content is present" do
        # review1 = Fabricate(:review, content: "Specified Content")
        # review1.update_columns(content: nil)
        # expect(Review.first.has_content?).to be_false
        expect(Review.first.has_content?).to be_true
      end
    end
  end

  describe '#has_rating?' do
    context "given a review object" do
      let!(:review1) { Fabricate(:review, rating: 4)}
    
      it "should return false if there is a nil rating"  do
        review1.update_columns(rating: nil)
        expect(Review.first.has_rating?).to be_false
      end
      it "should return false if there is no rating"  do
        review1.update_columns(rating: nil)
        expect(Review.first.has_rating?).to be_false
      end
      it "should return false if rating is a string rating"  do
        review1.update_columns(rating: 'Rating')
        expect(Review.first.has_rating?).to be_false
      end
      it "should return true if a rating is present" do
        expect(Review.first.has_rating?).to be_true
      end
    end
  end
end
