shared_examples "require sign in" do
  it "redirects to the root path" do
    session[:user_id] = nil
    
    action

    expect(response).to redirect_to root_path
  end
end