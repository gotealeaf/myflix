require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "with unauthenticated users" do
      it "redirects to the sign_in_path"
      it "does not create the review"
    end

    context "with authenticated users" do
      context "with invalid data" do
        it "sets @review"
        it "does not create the review"
        it "renders :show"
        it "sets warning"
      end

      context "with valid data" do
        it "creates the review"
        it "sets info"
        it "redirects to show_path"
      end
    end
  end
end