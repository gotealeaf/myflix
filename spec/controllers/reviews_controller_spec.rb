require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "athenticated users" do
      it "creates a new review object"
      it "associates the review with the video"
      it "associates the review with the current user"
      context "the data is valid" do
        it "saves the review"
        it "redirects to the 'video/show' page"
      end
      context "the data is not valid" do
        it "does not save the review"
        it "renders the 'video/show' page"
        it "shows the errors"
      end
    end
    context "unauthenticated users" do
      it "redirects to the sign-in page"
    end    
  end
end