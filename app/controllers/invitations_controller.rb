class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end
end