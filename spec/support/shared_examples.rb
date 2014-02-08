shared_examples "requires sign in" do
  it "should redirect to the sign in page" do
    clear_session
    action
    expect(response).to redirect_to sign_in_path
  end
end

 shared_examples "tokenable" do
  it "should generate a random token at create" do
      expect(object.token).to be_present
  end
end