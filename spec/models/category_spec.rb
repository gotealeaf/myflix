require 'spec_helper'

describe Category do 
	
	it { should have_many(:videos).order(:title	) }
	it { should have_many(:videos).through(:video_categories) }
	it {should validate_presence_of(:name) }

	
end