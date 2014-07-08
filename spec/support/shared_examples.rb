shared_examples "require sign in" do
  it "redirects to the root path" do
    session[:user_id] = nil 
    action
    expect(response).to redirect_to root_path
  end
end

shared_examples "tokenable" do
  it "generates a random token when the user is created" do
    expect(object.token).to be_present
  end
end