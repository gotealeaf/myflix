jQuery(function($) {
  $('#new_user').submit(function(event) {
    var $form = $(this);
    $form.find('.btn-default').prop('disabled', true);
    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#card_cvc').val(),
      exp_month: $('#card-expiry-month').val(),
      exp_year: $('#card-expiry-year').val()
    }, stripeResponseHandler);

    return false;
  });
});

function stripeResponseHandler(status, response) {
  var $form = $('#new_user');
  if (response.error) {
    $form.find('.payment-errors').text(response.error.message);
    $form.find('.btn-default').prop('disabled', false);
  } else {
    var token = response.id;
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    $form.get(0).submit();
  }
};
