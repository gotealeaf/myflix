shared_examples "require_sign_in" do 
  it "redirects to the front page" do
    clear_current_user
    action
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "does_not_require_sign_in" do 
  it "allows the user in" do
    clear_current_user
    action
    expect(response).to_not redirect_to sign_in_path
  end
end



