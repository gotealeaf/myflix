class Admin::PaymentsController < AdminController

  def index
    @payments = Payment.all
  end
end