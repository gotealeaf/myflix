shared_examples "require_login" do
  it "redirects to login path" do
    expect(response).to redirect_to login_path
  end
end

shared_examples "redirect_to_my_queue" do
  it "redirects to the my_queue screen" do
    action
    expect(response).to redirect_to my_queue_path
  end
end