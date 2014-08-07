shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to signin_path
  end
end

shared_examples "invalid token expired" do
  it "redirects to invalid token page if invalid token" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to invalid_token_path
  end
end

shared_examples "tokenify" do
  it "generate token when save" do

    expect(object.token).to be_present
  end
end
