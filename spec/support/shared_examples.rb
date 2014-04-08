shared_examples "requires sign in" do
  it "should redirect to login page" do
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "requires admin" do
  it "should redirect the regular user to home page" do
    session[:user_id] = Fabricate(:user)
    action
    expect(response).to redirect_to home_path
  end
  it "should set erro message for regular user" do
    session[:user_id] = Fabricate(:user)
    action
    expect(flash[:danger]).to be_present
  end
end

shared_examples "tokenable" do
  it "should generate a random token when object is created" do
    expect(object.token).to be_present
  end
end
