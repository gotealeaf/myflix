require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with autenticated users" do
      context "with valid inputs" do
        it "create a review"
        it "create a review associated with the video"
        it "create a review associated with the signed in user"
        it "redirect to the video show page"
      end
      context "with invalid inputs"
    end
  end
end