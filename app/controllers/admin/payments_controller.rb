class Admin::PaymentsController < AdminsController
  def index
    @payments = Payment.all
  end
end