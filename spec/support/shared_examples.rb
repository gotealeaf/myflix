shared_examples "require_sign_in" do 

  it "redirects to sign-in path" do
    remove_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
  
end