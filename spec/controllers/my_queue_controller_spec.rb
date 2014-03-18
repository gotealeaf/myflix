require 'spec_helper'

describe MyQueueController do

  describe "GET my_queue" do
    context "authenticated user" do
      before {session[:user_id] = Fabricate(:user).id}
      it "displays the video que for the current user" do
        video = Fabricate(:video)
        que = MyQueue.new(list_num:1, video_id: video.id)

        get :index

        expect(MyQueue.first).to eq que
      end

    end #context auth user
    
    context "unauthenticated user" do
      it "redirects user to sign_in page"
    end #un-auth user

  end #GET myqueue

  describe "POST create" do
    context "authenticated user" do
      it "adds the displayed video to the que"

      it "adds the "
    end #auth user
  end #POST create

  describe "UPDATE my_queue" do
    context "authenticated user" do

      it "changes the order of que"

      it "adds rating for a video in the que"

      it "can remove a video from the que"


    end #context auth user
    
  end #UPDATE my_queue

end
