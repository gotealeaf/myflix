
  def set_user1

      let(:user1) {Fabricate(:user)}
      # let(:use) {User.create(full_name: 'name', email: 'a@b', password 'pass')}
  end



  def set_user_and_session
    let(:alice) {Fabricate(:user)}
    before {session[:user_id] = alice.id}
    
  end

  def clear_session
      session[:user_id] = nil
  end

  def current_user
    @current_user = @current_user || User.find(session[:user_id])
    
  end

  def set_video
    let(:video) {Fabricate(:video)}
  end

  def set_video1
    let(:video1) {Fabricate(:video, title: 'Video1')}
  end


  def create_queue_item
    post :create, video_id: video.id  
  end

  def set_queue_of_2
    let(:video)  {Fabricate(:video)}
    let(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video)}
    let(:queue_item2) {Fabricate(:queue_item, user: current_user, position: 2, video: video)}
  end

  def set_category1
     let(:category1)  {Category.create(name: "Category1")}
    
  end

  def set_queue_item1
     let(:queue_item1)  {Fabricate(:queue_item, video: video1, user: user1)}
    
  end

  def set_review1
      let(:review1) {Fabricate(:review, rating: 1, video: video1, user: user1, content: 'Content1')}
    
  end