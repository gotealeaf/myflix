require 'spec_helper'
require 'pry'
require 'shoulda-matchers'

describe User do
  it { should have_secure_password}
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  describe "number_of_queue_items" do
    it 'returns the correct number of queue items' do
      adam = Fabricate(:user)
      queue_item1 = Fabricate(:queue_item, user: adam)
      queue_item2 = Fabricate(:queue_item, user: adam)
      expect(adam.number_of_queue_items).to eq(2)
    end

    it 'returns the number of the users reviews' do
      adam = Fabricate(:user)
      review1 = Fabricate(:review, user: adam)
      review2 = Fabricate(:review, user: adam)
      expect(adam.number_of_reviews).to eq(2)
    end
  end
end
