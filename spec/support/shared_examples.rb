shared_examples "requires sign in" do
  it "should redirect to login page" do
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "tokenable" do
  it "should generate a random token when object is created" do
    expect(object.token).to be_present
  end
end
