require "spec_helper"

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it "should be validate uniq of email " do
    user = Fabricate :user
    user.save
    expect(user).to validate_uniqueness_of :email
  end
  it { should validate_presence_of(:email) }
  it { should have_many(:queue_items).order(:order) }
end