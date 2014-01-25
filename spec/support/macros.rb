  def sign_in(feature_user=nil)
    user = feature_user || Fabricate(:user)
    visit sign_in_path
    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: user.password
    click_button "Sign in"
  end






  def set_user1
      let!(:user1) {Fabricate(:user)}
      # let(:user) {User.create(full_name: 'name', email: 'a@b', password 'pass')}
  end



  def set_user_and_session
    let(:user1) {Fabricate(:user)}
    before {session[:user_id] = user1.id}
    
  end

  def clear_session
      session[:user_id] = nil
  end

  def current_user
   User.find(session[:user_id])
    # @current_user = @current_user || User.find(session[:user_id])
    
  end



  def set_video(number=nil, options = {})
    unless number
      let!(:video) {Fabricate(:video)}
    else
      # let!(:video) {Fabricate(:video)}
      let!("video#{number}".to_sym) {Fabricate(:video, title: "Video#{number}", description: "Video_Description#{number}")}
    end
  end

  def set_video1
    let!(:video1) {Fabricate(:video, title: 'Video1')}
  end

  def set_category1
    let!(:category1) {Fabricate(:category, name: "Category1")}
  end



  def create_queue_item
    post :create, video_id: video.id  
  end

  def set_queue_of_2
    let!(:video)  {Fabricate(:video)}
    let!(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video)}
    let!(:queue_item2) {Fabricate(:queue_item, user: current_user, position: 2, video: video)}
  end

  def set_category(number=nil)
   unless number
      let!(:category) {Fabricate(:category)}
    else
      let!("category#{number}".to_sym) {Fabricate(:category, name: "Category#{number}")}
    end
  end

  def set_queue_item1
     let!(:queue_item1) { Fabricate(:queue_item, user: user1, position: 1, video: video1)}
    
  end

  def set_review1
      let!(:review1) {Fabricate(:review, rating: 1, video: video1, user: user1, content: 'Content1')}
    
  end

  def input_invalid_queue_position
    post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
    
  end