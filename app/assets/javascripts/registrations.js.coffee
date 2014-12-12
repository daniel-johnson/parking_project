$ ->
  return if typeof(Stripe) == "undefined"
  Stripe.setPublishableKey($("meta[name=stripe-key]").attr("content"))

  $form = $('#token-form')
  $hiddenStripeField = $("#user_customer_id")

  getStripeToken = ->
    $("#stripe-errors").html ""
    $("input[type=submit]").prop "disabled", true
    card =  
      number: $("#user_card_number").val()
      cvc: $("#user_cvc").val()
      expMonth: $("#date_month").val()
      expYear: $("#date_year").val()
    Stripe.createToken card, handleStripeResponse

  disableCreditCardInfoFields = ->
    $("#user_card_number").remove()
    $("#user_cvc").remove()
    $("#date_month").remove()
    $("#date_year").remove()

  handleStripeResponse = (status, response) ->
    if status == 200
      $hiddenStripeField.val(response.id)
      disableCreditCardInfoFields()
      $form.submit()
    else
      $("#stripe-errors").html response.error.message
      $("input[type=submit]").prop "disabled", false

  $form.on "submit", (e) -> 
    if $hiddenStripeField.val() == ''
      e.preventDefault()
      getStripeToken()