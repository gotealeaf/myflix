shared_examples "requires login" do
  it "redirects to login path" do
    expect(response).to redirect_to login_path
  end
end

shared_examples "redirects to my queue page" do
  it "redirects to the my_queue page" do
    expect(response).to redirect_to my_queue_path
  end
end

shared_examples "redirects to my queue after action" do
  it "redirects to the my_queue screen" do
    action
    expect(response).to redirect_to my_queue_path
  end
end

shared_examples "sets a flash error message" do
  it "sets a flash error message" do
    expect(flash[:danger]).to eq(message)
  end
end

shared_examples "tokenable" do 
  it "generates a random new token when the object is created" do 
    expect(object.token).to be_present
  end
end

