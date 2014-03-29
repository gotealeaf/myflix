require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password).on(:create) }
  it { should validate_presence_of(:password_confirmation).on(:create) }
  it { should have_secure_password }
  it { should have_many(:reviews) }

  it "returns reviews in reverse chronological order" do
    user = Fabricate(:user)
    review_1 = Fabricate(:review, user: user, created_at: 2.day.ago)
    review_2 = Fabricate(:review, user: user)
    expect(user.reviews).to eq([review_2, review_1])
  end

  it "validates uniqueness of email" do
    user = User.create(email: "smaug@lonelymountain.com", full_name: "Smaug the Magnificent", password: "gold", password_confirmation: "gold")
    expect(user).to validate_uniqueness_of :email
  end
end