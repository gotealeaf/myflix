jQuery(function($) {
  $('#payment-form').submit(function(event) {
    var $form = $(this);
    $form.find('button').prop('disabled', true);
    Stripe.card.createToken($form, stripeResponseHandler);
    return false;
  });
});

var stripeResponseHandler = function(status, response) {
  var $form = $('#payment-form');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('button').prop('disabled', false);
  } else {
    // token contains id, last4, and card type
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    // and submit
    $form.get(0).submit();
  }
};