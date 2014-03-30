require 'spec_helper'

describe User do
  before { @joe_user = User.new(name: "Joe", email: "joe@email.com", password: "foobar") }


  it { should validate_uniqueness_of( :email       )}
  it { should validate_presence_of(   :email       )}
  it { should validate_presence_of(   :name        )}
  it { should validate_presence_of(   :password    )}


  it "with proper attributes is valid" do
    expect(@joe_user).to be_valid
  end

  it "should create a 1-way digest for the user's password using BCrypt-ruby" do
    @joe_user.save
    expect(User.first).to eq(@joe_user)
  end

  it "should not let a user in with a wrong password" do
    @joe_user.save
    expect(@joe_user.authenticate("wrong_pass")).to eq(false)
  end

  it "should not let a user in with a wrong password" do
    @joe_user.save
    expect(@joe_user.authenticate(@joe_user.password)).to eq(@joe_user)
  end
end
