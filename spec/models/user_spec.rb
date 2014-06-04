require 'spec_helper'

describe User do
  it "requires a fullname" do
    user = User.new(full_name: "")
    expect(user).not_to be_valid
    expect(user.errors[:full_name].any?).to be_true
  end

  it "requires an email" do
    user = User.new(email: "")
    expect(user).not_to be_valid
    expect(user.errors[:email].any?).to be_true
  end

  it "requires a password" do
    user = User.new(password: "")
    expect(user).not_to be_valid
    expect(user.errors[:password].any?).to be_true
  end
end
