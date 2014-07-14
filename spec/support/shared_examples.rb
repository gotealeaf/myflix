shared_examples 'redirect for authenticated user' do
  it 'should redirect to my_queue page' do
    action
    expect(response).to redirect_to my_queue_path
  end
end

shared_examples 'redirect for unauthenticated user' do
  it 'should redirect to sign_in page' do
    action
    expect(response).to redirect_to sign_in_path
  end
end
