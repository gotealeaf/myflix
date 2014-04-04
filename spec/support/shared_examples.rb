shared_examples "require_signed_in" do
  it "redirects to the signin path if user is not signed in" do
    logout_user
    verb_action
    expect(response).to redirect_to signin_path
  end
end

shared_examples "require_signed_out" do
  it "redirects to the root page if user is still signed in (ie: not signed out)" do
    sign_in_user(current_user)
    verb_action
    expect(response).to redirect_to root_path
  end
end
