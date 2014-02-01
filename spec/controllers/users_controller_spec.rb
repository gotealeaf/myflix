require 'spec_helper'

describe UsersController do

  describe 'GET #new' do
    it 'should set up @user variable' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST #create' do
    context 'with valid input' do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'logs user in' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'shows success message' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects to home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid input' do
      before { post :create, user: { email: 'user@example.com', full_name: 'Joe Smith' } }

      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'renders new template' do
        expect(response).to render_template :new
      end

      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe 'PATCH #update_queue' do
    before do
      request.env["HTTP_REFERER"] = "http://fake.referal/id" unless request.nil? or request.env.nil?
    end

    context 'authorized user' do
      let!(:user) { Fabricate(:user) }
      let!(:video1) { Fabricate(:video) }
      let!(:video2) { Fabricate(:video) }
      let!(:queue_item1) { Fabricate(:queue_item, video: video1, position: QueueItem.next_available_position(user), user: user, created_at: 1.day.ago) }
      let!(:queue_item2) { Fabricate(:queue_item, video: video2, position: QueueItem.next_available_position(user), user: user) }

      before do
        session[:user_id] = user.id
      end

      context 'with valid position parameters' do
        it 'changes the order of videos in the queue' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: 2 }, queue_item2.id => { position: 1 } } }
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end

        it 'breaks video order ties automatically' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item2.id => { position: 1 }, queue_item1.id => { position: 1 } } }
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end

        it 'does not change queue position if user does not own queue item' do
          user2 = Fabricate(:user)
          session[:user_id] = user2.id
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: 3 } } }
          expect(queue_item1.reload.position).to eq(1)
        end

        it 'repositions queue items in order to fill any holes' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item2.id => { position: 2 }, queue_item1.id => { position: 4 } } }
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end

        it 'sets success message' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item2.id => { position: 2 }, queue_item1.id => { position: 4 } } }

          expect(flash[:success]).not_to be_blank
        end

        it 'redirects to previous page' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: 2 }, queue_item2.id => { position: 1 } } }
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end
      end

      context 'with invalid position parameters' do
        it 'does not alter the positions of items in the queue' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: '1.7' }, queue_item2.id => { position: '0.7' } } }
          expect(queue_item1.reload.position).to eq(1)
          expect(queue_item2.reload.position).to eq(2)
        end

        it 'sets an error message' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: '1.7' }, queue_item2.id => { position: '0.7' } } }
          expect(flash[:danger]).not_to be_blank
        end

        it 'redirects to previous page' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: '1.7' }, queue_item2.id => { position: '0.7' } } }
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end

        it 'rolls back the transaction' do
          queue_item3 = Fabricate(:queue_item, user: user, position: QueueItem.next_available_position(user))

          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: '1.7' }, queue_item2.id => { position: '3' }, queue_item3.id => { position: '2' } } }
          expect(queue_item2.reload.position).to eq(2)
        end
      end

      context 'with valid rating parameters' do
        let!(:review) { Fabricate(:review, rating: 3, creator: user, video: video1) }

        it 'updates existing review ratings' do
          review2 = Fabricate(:review, rating: 3, creator: user, video: video2)
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { rating: 1 }, queue_item2.id => { rating: 2 } } }
          expect(review.reload.rating).to eq(1)
          expect(review2.reload.rating).to eq(2)
        end

        it 'creates new, blank reviews for any previously unreviewed videos' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item2.id => { rating: 2 } } }
          expect(Review.find_rating_by_creator_and_video(user, video2)).to eq(2)
        end

        it 'sets success message' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item2.id => { rating: 2 } } }

          expect(flash[:success]).not_to be_blank
        end

        it 'redirects to the previous page' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item2.id => { rating: 2 } } }
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end
      end

      context 'with invalid rating parameters' do
        let!(:review) { Fabricate(:review, rating: 3, creator: user, video: video1) }

        it 'does not alter the ratings of the items in the queue' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { rating: '' } } }
          expect(review.reload.rating).to eq(3)
        end

        it 'sets an error message' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { rating: '' }, queue_item2.id => { rating: 100 } } }
          expect(flash[:danger]).not_to be_blank
        end

        it 'redirects to the previous page' do
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { rating: '' } } }
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end

        it 'rolls back the transaction' do
          review2 =  Fabricate(:review, rating: 3, creator: user, video: video2)
          patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { rating: 2 }, queue_item2.id => { rating: 100 } } }
          expect(review.reload.rating).to eq(3)
        end
      end

      context 'with both rating and position parameters'
    end

    context 'unauthorized user' do
      it 'redirects to sign in page' do
        user = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item)
        patch :update_queue, id: user.id, user: { queue_item: { queue_item1.id => { position: 2 } } }
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
