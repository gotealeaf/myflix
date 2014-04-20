jQuery(function($) {
  $('#payment-form').submit(function(event) {
    //this form
    var $form = $(this);
    //Sets button property: 'disabled = true' to prevent 2x click
    $form.find('.payment_submit').prop('disabled', true);
    //Send form values to Stripe to create token & respond back
    Stripe.card.createToken({
      number: $('.card-number').val(),
      cvc: $('.card-cvc').val(),
      exp_month: $('.card-expiry-month').val(),
      exp_year: $('.card-expiry-year').val()
    }, stripeResponseHandler);
    //Hijacks the form to prevent it from sending to our server
    return false;
  });

  //This var is called from above function
  var stripeResponseHandler = function(status, response) {
    var $form = $('#payment-form');

    if (response.error) {
      //Show errors on form in the prior-blank css class .payment-errors holder
      $form.find('.payment-errors').text(response.error.message);
      //Now set button property to enabled
      $form.find('.payment_submit').prop('disabled', false);
    } else {
      //token contains id, last4, card-type
      var token = response.id
      //Add the response token into a hidden field in the form for send to server
      $form.append($('<input type="hidden", name="stripeToken" />').val(token));
      //and submit
      $form.get(0).submit();
    }
  };
});
