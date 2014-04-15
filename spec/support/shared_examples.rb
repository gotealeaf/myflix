shared_examples "requires_login" do
  it "redirects to login path" do
    expect(response).to redirect_to login_path
  end
end

shared_examples "redirects_to_my_queue_page" do
  it "redirects to the my_queue page" do
    expect(response).to redirect_to my_queue_path
  end
end

shared_examples "redirects_to_my_queue_after_action" do
  it "redirects to the my_queue screen" do
    action
    expect(response).to redirect_to my_queue_path
  end
end

shared_examples "sets_a_flash_error_message" do
  it "sets a flash error message" do
    expect(flash[:danger]).to eq(message)
  end
end

