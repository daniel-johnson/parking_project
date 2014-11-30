class Stripe::CreateCustomer

  include Virtus.model

  attribute :user, User
  attribute :stripe_token, String

  def call
    begin
      @customer = Stripe::Customer.create(
        description: description,
        card: stripe_token
      )
      save_users_stripe_info
    rescue => e
      Rails.logger.error ">>>>>>>>>>>>>>>> #{e.message}"
      false
    end
  end

  private

  def description
    "Customer for #{user.full_name} | #{user.email}"
  end

  def save_users_stripe_info
    user.stripe_customer_token  = @customer.id
    user.stripe_last_4_digits   = @customer.cards.data[0].last4
    user.stripe_card_type       = @customer.cards.data[0].brand
    user.save
  end

end
