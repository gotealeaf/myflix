class PagesController < ApplicationController
  before_action :require_signed_out, only: [:front, :confirm_email_sent]

  def front
  end

  def confirm_password_reset_email
  end
end
