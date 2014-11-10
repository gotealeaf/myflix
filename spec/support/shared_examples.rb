
shared_examples "require_sign_in" do
  it "redirects to the sign in page" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
  
  shared_examples "tokenable" do
    it "generates a random token when the object is created" do
      expect(object.token).to be_present
    end
  end
  
end