require 'spec_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe "search_by_title" do
    it "returns an empty array if string does not match any titles" do
      video1 = Fabricate(:video, title: "Futurama")
      video2 = Fabricate(:video, title: "Back to Future")
      search = "unmatched_title"
      expect(Video.search_by_title(search)).to eq([])
    end

    it "returns a one-video array if the string exactly matches one title" do
      video1 = Fabricate(:video, title: "Futurama")
      video2 = Fabricate(:video, title: "Back to Future")
      search = "futurama"
      expect(Video.search_by_title(search)).to eq([video1])
    end

    it "returns an array of one video for a partial match" do
      video1 = Fabricate(:video, title: "Futurama")
      video2 = Fabricate(:video, title: "Family Guy")
      video3 = Fabricate(:video, title: "Family Comedy")
      search = "futur"
      expect(Video.search_by_title(search)).to eq([video1])
    end

    it "returns an array of all matches, ordered by created_at" do
      video1 = Fabricate(:video, title: "Futurama")
      video2 = Fabricate(:video, title: "Family Guy", created_at: 1.day.ago)
      video3 = Fabricate(:video, title: "Family Comedy")
      search = "family"
      expect(Video.search_by_title(search)).to eq([video3, video2])
    end

    it "returns an empty array when search term is empty string" do
      video1 = Fabricate(:video, title: "Futurama")
      video2 = Fabricate(:video, title: "Family Guy")
      video3 = Fabricate(:video, title: "Family Comedy")
      search = ""
      expect(Video.search_by_title(search)).to eq([])
    end
  end


  describe "average_rating" do
    before { video = Fabricate(:video) }

    context "no ratings exist" do
      it "returns '-' if no ratings exist" do
        expect(Video.first.average_rating).to eq('-')
      end
    end

    context "one rating exists" do
      it "returns the rating if one rating exists" do
        rating = rand(1..5).to_f
        review = Fabricate(:review, rating: rating, video_id: Video.first.id)
        expect(Video.first.average_rating).to eq(rating.to_s)
      end
    end

    context "multiple ratings exist" do
      it "returns the average rating, rounded to one decimal place" do
        sum, review_count = 0, 15
        user_id = 1
        review_count.times do
          rating = rand(1..5).to_f
          review = Fabricate(:review, rating: rating, video_id: Video.first.id, user_id: user_id)
          user_id += 1
          sum += rating
        end
        expect(Video.first.average_rating).to eq((sum / review_count).round(1).to_s)
      end
    end
  end

end