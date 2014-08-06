shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to signin_path
  end
end
