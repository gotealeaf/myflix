shared_examples "require_sign_in" do
 it "redirects to the sign in page" do
  clear_current_user
  action
  response.should redirect_to sign_in_path 
 end 
end

shared_examples "requires admin" do 
  it "redirects to home path if not admin" do 
    set_current_user 
    action
    response.should redirect_to home_path
  end
end

shared_examples "tokenable" do 
  it "generates a random token when the user is created" do 
    object.token.should be_present
  end
end