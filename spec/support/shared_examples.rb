shared_examples "require sign in" do
  it "redirects to the sign-in page" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "tokenable" do |model|
  it "creates a token when a record is created" do
    object = Fabricate(model)
    expect(object.token).not_to be(nil)
  end
end

shared_examples "require admin" do
  it "should redirect non-admin users to the root" do
    set_current_user
    action
    expect(response).to redirect_to root_path
  end
end