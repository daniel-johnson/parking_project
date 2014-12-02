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
      user.customer_id  = @customer.id
      user.save
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
