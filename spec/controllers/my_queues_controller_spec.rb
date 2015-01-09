require 'rails_helper'

describe MyQueuesController do 
  let(:myqueue) { Fabricate(:my_queue)}
  describe 'GET Show' do
    context 'show action' do
      before do
        3.times do
          video = Fabricate(:video)        
          MyQueueVideo.create(video: video, my_queue: myqueue, index: 1 )
        end
      end
      it 'should set the correct video attribute' do      
        user = User.first
        login(user)
        get 'show'
        assigns(:my_queue_videos).size.should == 3
      end
      it 'should render the show template' do
        user = User.first
        login(user)
        get 'show'
        response.should render_template :show
      end

      it 'should redirect to root path if access denied' do
        get 'show'
        response.should redirect_to root_path
      end
    end    
  end
end