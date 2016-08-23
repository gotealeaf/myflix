require 'spec_helper'

describe Category do 
	it { should have_many(:videos) }

	describe '#recent_videos' do 
		it 'returns all the videos if there are less than six' do 
			comedy = Category.create(name: 'comedy')
			3.times do |i|
				Video.create(title: "video ##{i}", description: "video number #{i}", category: comedy)
			end
			expect(comedy.recent_videos.size).to eq(3)
		end
		it 'returns the first six videos if there are more than six' do 
			comedy = Category.create(name: 'comedy')
			10.times do |i|
				Video.create(title: "video ##{i}", description: "video number #{i}", category: comedy)
			end
			expect(comedy.recent_videos.size).to eq(6)
		end 
		it 'returns the videos ordered by reverse chronological creation date' do 
			comedy = Category.create(name: 'comedy')
			rush_hour = Video.create(title: 'Rush Hour', description: 'Jackie Chan and Chris Tucker', category: comedy)
			the_judge = Video.create(title: 'The Judge', description: 'Robert Duvall', category: comedy, created_at: 2.weeks.ago)
			galavant = Video.create(title: 'Galavant', description: 'best comedy', category: comedy, created_at: 1.day.ago)
			expect(comedy.recent_videos).to eq([rush_hour, galavant, the_judge])
		end
		it 'returns an empty array if there are no videos' do
			comedy = Category.create(name: 'comedy') 
			expect(comedy.recent_videos).to eq([])
		end

		it 'returns the 6 most recent videos' do 
			comedy = Category.create(name: 'comedy')
			7.times do |i|
				Video.create(title: "video #{i}", description: "video number #{i}", category: comedy)
			end
			rush_hour = Video.create(title: 'Rush Hour', 
				description: 'Starring Jackie Chan and Chris Tucker',
				created_at: 5.days.ago)
			expect(comedy.recent_videos).to_not include(rush_hour)
		end
	end
end