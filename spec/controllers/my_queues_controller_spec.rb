require "spec_helper"

describe MyQueuesController do
  context "authenticatedd user" do  
    describe "GET index" do
      it "sets @my_queue variable" do 
        user = Fabricate :user
        video1 = Fabricate :video
        video2 = Fabricate :video
        video3 = Fabricate :video

        queue1 = Fabricate(:my_queue, video: video1, user: user)
        queue2 = Fabricate(:my_queue, video: video2, user: user)
        queue3 = Fabricate(:my_queue, video: video3, user: user)

        user.my_queues = [queue1, queue2, queue3]

        get :index, id: user.id

        expect(assigns :my_queue).to eq([queue1, queue2, queue3])
      end
    end

    # describe "POST update"
    #   it "updates the order" do

    #   end

    #   it "updates videos rating" do

    #   end

    #   it "redirects to my-queue page" do 

    #   end
    # end

    # describe "GET delete"
    #   it "removes the video from the queue" do

    #   end

    #   it "renders my-queue template" do

    #   end
    # end
  end

  context "unauthenticated user" do 
    describe "GET show" do
      it "redirects to sign_in page" do 

      end
    end
  end
end