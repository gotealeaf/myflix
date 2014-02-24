require 'spec_helper'
require 'pry'

describe QueueItems Controller do
  describe 'POST #create' do
    context 'signed in user' do

      it 'sets the QueueItem object correctly based on params'
      it 'assigns the user_id correctly'
      it 'assigns the video_id correctly'

      context 'already in queue' do
        it 'shows error message'
        it 'redirects user to queue page'
      end
      context 'if not already in queue' do
        context 'valid params' do
          it 'checks if there is a position set'

          context 'there is a position set' do
            it 'checks if other video has same position'
            it 'assigns position to that video'
            it 'assigns new position to all later videos'
          end

          context 'there is not position set' do
            it 'assigns position position'
          end
          it 'sucessfully saves QueueItem'
          it 'redirects user to queue_item_path'
          it 'shows positive confirmation'
        end
        context 'invalid params' do
          it 'fails to save QueueItem'
          it 'redirects user to video_show_path'
          it 'shows error message'
        end
      end
    end
  end
  context 'invalid user' do
    it 'redirects user to login_path'
    it 'displays error message to user'
  end
end
