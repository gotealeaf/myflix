require 'spec_helper'

describe User do
  it { should validate_uniqueness_of( :email       )}
  it { should validate_presence_of(   :email       )}
  it { should validate_presence_of(   :name        )}
  it { should validate_presence_of(   :password    )}

  let(:user) { User.new(name: "Joe", email: "joe@email.com", password: "foobar") }


  it "with proper attributes is valid" do
    expect(user).to be_valid
  end

  it "should create a 1-way digest for the user's password using BCrypt-ruby" do
    user.save
    expect(User.first).to eq(user)
  end

  it "should not let a user in with a wrong password" do
    user.save
    expect(user.authenticate("wrong_pass")).to eq(false)
  end

  it "should not let a user in with a wrong password" do
    user.save
    expect(user.authenticate(user.password)).to eq(user)
  end
end
