$ ->
  return if typeof(Stripe) == "undefined"
  Stripe.setPublishableKey($("meta[name=stripe-key]").attr("content"))

  $("#cc-form").on "submit", ->
    $("#stripe-errors").html ""
    $("input[type=submit]").prop "disabled", true
    card =
      number: $("#_card_number").val()
      cvc: $("#_cvc").val()
      expMonth: $("#date_month").val()
      expYear: $("#date_year").val()
    Stripe.createToken card, handleStripeResponse
    false

  handleStripeResponse = (status, response) ->
    if status == 200
      $("#_stripe_card_token").val response.id
      $("#token-form #_email").val $("#cc-form #_email").val()
      $("cc-form#token-form").submit()
    else
      $("#stripe-errors").html response.error.message
      $("input[type=submit]").prop "disabled", false