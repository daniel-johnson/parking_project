class Registration::CreateWithStripe

  include Virtus.model

  attribute :user, User
  attribute :stripe_token, String

  def call
    begin
      @customer = Stripe::Customer.create(
        description: description,
        card: stripe_token
      )
      user.customer_id = @customer.id
      user.last_4 = @customer.cards.data[0].last4
      user.exp_month = @customer.cards.data[0].exp_month
      user.exp_year = @customer.cards.data[0].exp_year
      return true
    rescue => e
      Rails.logger.error ">>>>>>>>>>>>>>>> #{e.message}"
      false
    end
  end

  private

  def description
    "Customer for #{user.full_name} | #{user.email} | #{user.license}"
  end

end