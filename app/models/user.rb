class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_reader :card_number, :expiry_date, :expiry_date, :cvc

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".strip
    else
      email
    end
  end
end
