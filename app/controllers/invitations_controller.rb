class InvitationsController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.merge!(inviter_id: current_user.id))
    if @invitation.save
      AppMailer.invite_email(@invitation).deliver
      flash[:success] = "Your invitation has been emailed to #{@invitation.full_name}"
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.new(Invitation.where(id: params[:id]).select('full_name, email').first.attributes)
    render 'users/new'
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :full_name, :message)
  end
end