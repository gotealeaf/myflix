require 'spec_helper'

describe Video do
	it { should belong_to(:category)}
	it { should validate_presence_of(:title)}
	it { should validate_presence_of(:description)}

  describe 'search_by_title' do

    it 'gives no result if search term is neither full nor partial match' do
      found = Video.create(title:'Found Highway', description: 'masterpiece!')
      lost = Video.create(title: 'Lost Highway', description:'nightmare!')
      expect(Video.search_by_title('travel')).to eq([])
    end

    it 'gives one result on exact match' do
      found = Video.create(title:'Found Highway', description: 'masterpiece!')
      lost = Video.create(title: 'Lost Highway', description:'nightmare!')
      expect(Video.search_by_title('Lost Highway')).to eq([lost])
    end
    
    it 'gives one result on partial match' do
      found = Video.create(title:'Found Highway', description: 'masterpiece!')
      lost = Video.create(title: 'Lost Highway', description:'nightmare!')
      expect(Video.search_by_title('ost Highway')).to eq([lost])
    end

    it 'gives more than one result on several partial matches' do
    	found = Video.create(title:'Found Highway', description: 'masterpiece!')
      lost = Video.create(title: 'Lost Highway', description:'nightmare!')
      expect(Video.search_by_title('Highway')).to eq([found, lost])
    end

    it 'gives no result if search term is empty string' do
    	found = Video.create(title:'Found Highway', description: 'masterpiece!')
      lost = Video.create(title: 'Lost Highway', description:'nightmare!')
      expect(Video.search_by_title(' ')).to eq([])
    end

  end
end
