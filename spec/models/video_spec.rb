require 'spec_helper'

describe Video do
	it { should belong_to(:category) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }

	describe "search_by_title" do
		it "returns an empty array if there is no match" do
			terminator = Video.create(title: "Terminator", description: "sci-fi movie")
			inception = Video.create(title: "Inception", description: "nice drama movie")
			expect(Video.search_by_title("hello")).to eq([])
		end

		it "returns an array of one video for an exact match" do
			terminator = Video.create(title: "Terminator", description: "sci-fi movie")
			inception = Video.create(title: "Inception", description: "nice drama movie")
			expect(Video.search_by_title("Inception")).to eq([inception])
		end

		it "returns an array of one video for a partial match" do
			terminator = Video.create(title: "Terminator", description: "sci-fi movie")
			inception = Video.create(title: "Inception", description: "nice drama movie")
			expect(Video.search_by_title("ception")).to eq([inception])
		end

		it "returns an array of all matches ordered by created_at" do
			incredibles = Video.create(title: "The Incredibles", description: "animated movie", created_at: 1.day.ago)
			inception = Video.create(title: "Inception", description: "nice drama movie")
			expect(Video.search_by_title("inc")).to eq([inception, incredibles])
		end

		it "returns an empty array for a search with an empty string" do
			incredibles = Video.create(title: "The Incredibles", description: "animated movie", created_at: 1.day.ago)
			inception = Video.create(title: "Inception", description: "nice drama movie")
			expect(Video.search_by_title("")).to eq([])
		end
	end
end
